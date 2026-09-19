# DeepSeek Harness Web — IIS 反向代理配置

记录通过 IIS + ARR + URL Rewrite 将 dsh web 反代到局域网（192.168.255.11:3080），并**解锁全部 loopback-only 端点**的完整配置方法。本文档基于 2026-09-14 实证，包含所有踩坑经验。

> 环境：Windows Server / Win11 + IIS 10、ARR 3.0、URL Rewrite 2.1、dsh web 0.1.5-rc.2

## 一、为什么需要反向代理

- dsh web **故意禁止** `--host 0.0.0.0`（安全原因：防止把远程代码执行暴露到网络），只允许监听 `127.0.0.1`。
- 因此外部访问只能通过本机代理转发：`外部浏览器 → IIS(3080) → 127.0.0.1:3081(dsh web)`。
- dsh 的 `/api` 有**双重信任防线**（详见第三节），反代必须同时满足才能解锁全部功能。

## 二、完整配置步骤（正确做法）

### 1. 安装必需模块（管理员 PowerShell）

```powershell
# ARR 3.0 + URL Rewrite 2.1（winget 安装）
winget install Microsoft.IIS.ApplicationRequestRouting
winget install Microsoft.IIS.URLRewrite

# 启用 WebSocket 功能（WebSocket 代理转发必需，启用后无需重启）
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebSockets
```

验证模块注册（应看到 RewriteModule）：

```powershell
C:\Windows\System32\inetsrv\appcmd.exe list modules | findstr /i "rewrite"
```

### 2. 修改 applicationHost.config（全局）

文件：`C:\Windows\System32\inetsrv\config\applicationHost.config`

**a) 在 `<system.webServer>` 内注册允许改写的服务器变量**（若 `<allowedServerVariables>` 不存在则新建）：

```xml
<system.webServer>
    <rewrite>
        <allowedServerVariables>
            <add name="HTTP_HOST" />
            <add name="HTTP_ORIGIN" />
        </allowedServerVariables>
    </rewrite>
    ...
</system.webServer>
```

**b) 修改 proxy 配置：移除 `preserveHostHeader="true"`**（保留 Host 头会导致 ARR 不改写 Host，见注意事项 #2）：

```xml
<!-- 修改前 -->
<proxy enabled="true" timeout="12:00:00" preserveHostHeader="true" responseBufferLimit="0" bufferChunkedResponses="false" />
<!-- 修改后：删除 preserveHostHeader 属性 -->
<proxy enabled="true" timeout="12:00:00" responseBufferLimit="0" bufferChunkedResponses="false" />
```

参数说明：

| 参数 | 值 | 作用 |
|---|---|---|
| `enabled` | `true` | 启用 ARR 代理 |
| `timeout` | `12:00:00` | 后端超时 12 小时（长任务/流式不断开） |
| `responseBufferLimit` | `0` | **禁用响应缓冲**，SSE 实时流即时到达 |
| `bufferChunkedResponses` | `false` | chunked 响应不缓冲 |
| `preserveHostHeader` | **移除** | 让 ARR 用转发目标主机作为 Host 头（这是 Host 伪装的关键） |

**c) 重启 IIS 使 applicationHost.config 生效**（注意：此文件修改后 W3SVC 可能自动停止，务必确认服务状态）：

```powershell
Restart-Service W3SVC -Force
Get-Service W3SVC        # 必须为 Running
```

### 3. 创建反向代理站点

```powershell
# 创建物理目录
New-Item -ItemType Directory -Path C:\inetpub\dsh-proxy -Force

# 创建站点（绑定 http/*:3080）
Import-Module WebAdministration
New-Website -Name "dsh-proxy" -PhysicalPath "C:\inetpub\dsh-proxy" -Port 3080
```

### 4. 编写 web.config（核心）

文件：`C:\inetpub\dsh-proxy\web.config`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
  <system.webServer>
    <rewrite>
      <rules>
        <rule name="ReverseProxyToDshWeb" stopProcessing="true">
          <match url="(.*)" />
          <action type="Rewrite" url="http://127.0.0.1:3081/{R:1}" />
          <!-- dsh 的 /api 信任层要求 Host 与 Origin 一致且为 loopback：
               ARR 移除 preserveHostHeader 后会把 Host 自动改为转发目标 127.0.0.1:3081（无需改写），
               但 Origin 头必须由本规则改写，否则浏览器 Origin(外部地址) 与 Host 不匹配导致 403。
               ⚠️ HTTP_ORIGIN 的值必须带 http:// 前缀（见注意事项 #1）-->
          <serverVariables>
            <set name="HTTP_HOST" value="127.0.0.1:3081" />
            <set name="HTTP_ORIGIN" value="http://127.0.0.1:3081" />
          </serverVariables>
        </rule>
      </rules>
    </rewrite>
    <security>
      <requestFiltering>
        <!-- dsh 支持大文件/附件上传，放开请求体限制到 2GB -->
        <!-- maxQueryString=65536：dsh 前端 /plugins/??a,b,c&rev=... 合并请求的查询串可达数 KB，
             超过 IIS 默认 2048 会返回 404.15，导致页面 JS 加载失败 -->
        <requestLimits maxAllowedContentLength="2147483648" maxQueryString="65536" maxUrl="16384" />
      </requestFiltering>
    </security>
  </system.webServer>
</configuration>
```

⚠️ **不要在 web.config 里配置 `<webSocket>` 节**：该配置节在站点级被锁定，只允许在服务器级配置（会导致 500.19，见注意事项 #3）。IIS-WebSockets 功能启用后全局生效，站点无需任何配置。

### 5. 防火墙放行

```powershell
# 放行 3080 入站 TCP（注意：命令可能因引号拆分执行两次，需检查是否重复）
New-NetFirewallRule -DisplayName "dsh-proxy 3080" -Direction Inbound -Protocol TCP -LocalPort 3080 -Action Allow
Get-NetFirewallRule -DisplayName "dsh-proxy 3080"   # 确认只有一条
```

### 6. dsh 侧配置（trustedHosts 持久化）

修改 `C:\Users\yashi\.dsh\profiles\web\cordis.patch.yml`，把反代主机加入白名单（这样**任意方式**启动 dsh web 都生效，不依赖启动参数）：

```yaml
# cordis.patch.yml
webStartup:
  trustedHosts:
    - '!!js/expr:["192.168.255.11:3080"]'   # ⚠️ 数组必须用 !!js/expr 表达式且加引号（见注意事项 #4）
```

> 等价命令：`dsh web --trusted-host 192.168.255.11:3080`（仅本次启动生效）。

### 7. 重启 dsh web 生效

```powershell
# 停止旧实例后启动（带日志重定向，便于获取认证 token）
dsh web --port 3081  > C:\Users\yashi\.dsh\web-3081.log 2>&1
# 认证 URL（含 token）在启动日志中：
type C:\Users\yashi\.dsh\web-3081.log
```

## 三、dsh 的信任防线机制（必读）

dsh 的 `/api` 请求要经过两道检查，反代必须同时满足：

### 防线 1：全局信任层（isTrustedApiRequest，作用于所有 /api）

```js
// 伪代码逻辑
1. Host 头必须为 loopback（127.0.0.1/localhost/[::1]）或在 trustedHosts 白名单中
2. sec-fetch-site 不能是 cross-site
3. 若带 Origin 头：new URL(origin).host 必须等于 Host 的主机   // ← Origin 校验！
```

### 防线 2：端点级 loopback-only 检查（isLoopbackRequest，作用于 35 个桌面集成端点）

```js
// 伪代码逻辑（notifier/pet/pair/preset/usage 等插件端点）
1. request.socket.remoteAddress 必须是 127.0.0.1 / ::1 / ::ffff:127.0.0.1   // TCP 来源必须 loopback
2. Host 头 hostname 必须是 127.0.0.1 / localhost / [::1]
3. sec-fetch-site 不能是 cross-site（除非 no-cors 例外）
4. 若带 Origin 头：new URL(origin).host === Host 的主机
```

### 为什么当前配置能全部通过

| 检查项 | 代理后实际值 | 结果 |
|---|---|---|
| socket.remoteAddress | `127.0.0.1`（IIS 与 dsh 同机，TCP 就是 loopback）| ✅ |
| Host 头 | `127.0.0.1:3081`（ARR 移除 preserveHostHeader 后自动使用转发目标主机）| ✅ |
| Origin 头 | `http://127.0.0.1:3081`（URL Rewrite serverVariables 改写，**必须带 http://**）| ✅ |
| X-Forwarded-For | `192.168.255.11:xxxx`（ARR 自动添加）| ✅ 无关（dsh 不信任 XFF，已验证）|

## 四、验证清单（curl 命令）

```bash
# 0. 基础连通（应返回 401 认证提示或 200）
curl -s -o /dev/null -w "%{http_code}\n" http://192.168.255.11:3080/

# 1. 认证流程（token 换 cookie；注意 Set-Cookie 的 dsh-auth- 名前缀即 authority 哈希）
curl -s -i "http://192.168.255.11:3080/?token=<启动日志中的token>" | grep -i "set-cookie\|HTTP/"

# 2. 带 cookie 访问主页（应 200）
curl -s -o /dev/null -w "%{http_code}\n" -H "Cookie: <cookie>" http://192.168.255.11:3080/

# 3. loopback-only 端点解锁验证（应非 403；405=POST 端点被 GET 请求的正常业务响应）
for ep in /api/pair/status /api/dsh-notifier/health /api/pet/state /api/dsh-usage/overview; do
  printf "%-28s -> " "$ep"
  curl -s -w " [%{http_code}]\n" --max-time 6 -H "Cookie: <cookie>" "http://192.168.255.11:3080$ep" | head -c 120; echo
done

# 4. WebSocket 升级（应 101）
curl -s -i --max-time 5 -H "Origin: http://192.168.255.11:3080" \
  -H "Connection: Upgrade" -H "Upgrade: websocket" \
  -H "Sec-WebSocket-Version: 13" -H "Sec-WebSocket-Key: dGhlIHNhbXBsZSBub25jZQ==" \
  -H "Cookie: <cookie>" "http://192.168.255.11:3080/api/remote.mux" | head -1

# 5. SSE 实时流（应秒回 : connected + 数据）
curl -s --max-time 3 -N -H "Origin: http://192.168.255.11:3080" \
  "http://192.168.255.11:3080/plugins/events" | head -c 300

# 6. POST 写操作（信任层放行后返回业务校验 400 而非 403）
curl -s -w " [%{http_code}]\n" -X POST -H "Origin: http://192.168.255.11:3080" \
  -H "Content-Type: application/json" -H "Cookie: <cookie>" \
  -d '' "http://192.168.255.11:3080/api/session/create"

# 7. 合并资源（大查询串，验证 maxQueryString 生效；约 200 且体积大）
curl -s -o /dev/null -w "%{http_code} (%{size_download} bytes)\n" --max-time 30 \
  -H "Cookie: <cookie>" "http://192.168.255.11:3080/plugins/??@deepseek-ai/dsh-client-modules/client.js&rev=<主页中的rev>"
```

## 五、注意事项与试错经验（2026-09-14 实证）

### #1（最隐蔽）HTTP_ORIGIN 值必须带 `http://` 前缀

- **现象**：Host 改写生效（token 认证 cookie authority 已是 `127.0.0.1:3081`），但所有 /api 仍 403。
- **根因**：`<set name="HTTP_ORIGIN" value="127.0.0.1:3081" />` 生成裸 authority 头。dsh 信任层执行 `new URL("127.0.0.1:3081")` **抛异常 → catch → return false → 403**。带 `http://` 前缀后 `new URL()` 正常解析，`.host === hostUrl.host` 匹配 → 通过。
- **排障方法**：起临时回显服务（Python http.server 打印全部请求头）对比直连/代理差异，发现 Origin 头值格式不对。
- **教训**：任何"拿 URL 当字符串"的逻辑都隐含 `new URL()` 解析，值必须带 scheme。

### #2 preserveHostHeader=true 会阻止 Host 伪装

- **现象**：伪造 `Host: 127.0.0.1:3081` 经代理仍 403。
- **根因**：`preserveHostHeader=true` 时 ARR **保留客户端原始 Host 头**（`192.168.255.11:3080`），serverVariables 的 HTTP_HOST 设置被覆盖。
- **解决**：移除该属性后，ARR 自动用**转发目标主机**（`127.0.0.1:3081`）作为 Host → loopback 检查通过。此时 HTTP_HOST serverVariables 实际不生效（ARR 优先），保留仅为与目标一致时无害。

### #3 站点级 `<webSocket>` 配置节被锁定

- **现象**：web.config 加了 `<webSocket>` 后站点报 **500.19** 无法启动。
- **根因**：`webSocket` 节只能在服务器级（applicationHost.config）配置，站点级被 schema 锁定。
- **解决**：从 web.config 移除。启用 IIS-WebSockets 功能后 WebSocket 反代全局生效，站点无需配置。

### #4 trustedHosts 数组必须用 `!!js/expr` 且加引号

- **现象**：`trustedHosts: [192.168.255.11:3080]` 写入 YAML 后 dsh 启动报 YAML 解析错误。
- **根因**：dsh 配置树的数组值由 JS 表达式（`!!js/expr`）注入；裸 YAML 数组与表达式语法冲突。
- **正确写法**：`- '!!js/expr:["192.168.255.11:3080"]'`（表达式字符串加引号）。

### #5 修改 applicationHost.config 后 W3SVC 可能停止

- **现象**：改完 applicationHost.config 后请求仍 403，检查发现 **W3SVC 服务状态为 Stopped**。
- **根因**：IIS 配置变更触发重读，期间服务可能停止；XML 语法错误会导致服务起不来。
- **解决**：改完必须 `Restart-Service W3SVC -Force` 并确认 `Get-Service W3SVC` 为 Running；修改前备份原文件。

### #6 合并资源 404 页面白屏（maxQueryString 默认 2048）

- **现象**：主页 HTML 能加载，但 `/plugins/??<50个模块>&rev=...`（查询串约 2805 字节）返回 404，页面 JS 加载失败 → 浏览器控制台大量报错/白屏。
- **根因**：IIS 请求过滤默认 `maxQueryString=2048`，超长查询串被拒绝。
- **解决**：`<requestLimits maxQueryString="65536" />`（见 web.config）。**IIS 自动热加载 web.config，无需重启**。

### #7 Host 伪装后旧 cookie 全部失效，需重新登录

- **现象**：Host 变为 `127.0.0.1:3081` 后，浏览器旧 cookie（authority=192.168.255.11:3080）登录态失效。
- **根因**：dsh 的 cookie 名含 authority 哈希（`dsh-auth-<hash(authority)>`），authority 变化则找不到匹配 cookie。
- **解决**：用当前实例的 token 重新访问 `http://192.168.255.11:3080/?token=<新token>` 完成新登录（cookie 有效期 30 天）。

### #8 dsh web 重启后 token 变化

- **现象**：dsh web 重启后旧 token 失效，浏览器全部请求 401。
- **根因**：launchToken 每次启动随机生成（内存态，不落盘）。
- **解决**：重启后从启动日志重新获取 token（`type C:\Users\yashi\.dsh\web-3081.log`）。

### #9 X-Forwarded-For 不影响 dsh 判定（已排除）

- ARR 会给每个请求加 `X-Forwarded-For: <外部IP>:<端口>`，但直连带伪造任意 XFF 均 200 → dsh **不信任 XFF**，判定只基于 socket.remoteAddress + Host + Origin。

### #10 合并资源偶发 404 是 dsh rev 防缓存机制

- 用旧 rev 请求合并资源返回 404（直连同样 404）→ 是 dsh 的模块清单 rev 校验，非代理问题。浏览器加载时页面与资源 rev 一致，不受影响。

### #11 update/status 慢（约 10 秒）不是代理问题

- `/api/update/status` 代理与直连都约 10 秒返回（更新检查本身慢），curl 默认 5 秒超时会显示 000，**非代理故障**。

### #12 防火墙命令引号陷阱

- Git Bash 中 `New-NetFirewallRule` 的引号可能被拆分导致命令执行两次（看似失败实际已创建）。执行后务必 `Get-NetFirewallRule` 检查去重。

### #13 风险提示（重要）

- 解锁 loopback-only 后，35 个桌面集成端点（含 `pair/lan-bind` 远程绑定、pet/notifier 控制）对**局域网全开放**，且 dsh 的 CSRF/DNS-rebinding 防线（专为"局域网+浏览器"设计）被双重伪造后形同虚设。请仅在可信网络使用。

## 六、日常运维速查

```powershell
# 启动 dsh web（后台 + 日志）
Start-Process -WindowStyle Hidden -FilePath "dsh" -ArgumentList "web","--port","3081" `
  -RedirectStandardOutput "C:\Users\yashi\.dsh\web-3081.log" `
  -RedirectStandardError "C:\Users\yashi\.dsh\web-3081.err.log"

# 查看认证 token
type C:\Users\yashi\.dsh\web-3081.log

# 停止所有 dsh web 实例
Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match "bin.js web --port 3081" } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force }

# 确认监听
Get-NetTCPConnection -LocalPort 3081 -State Listen

# IIS 站点状态
Get-Website -Name "dsh-proxy"

# 反代失败排查（502 时先确认后端存活）
curl -s -o /dev/null -w "%{http_code}\n" http://127.0.0.1:3081/
```

## 七、相关文件

| 文件 | 作用 |
|---|---|
| `C:\inetpub\dsh-proxy\web.config` | 反代规则 + 请求限制（改后自动热加载）|
| `C:\Windows\System32\inetsrv\config\applicationHost.config` | allowedServerVariables + proxy 全局配置（改后需重启 W3SVC）|
| `C:\Users\yashi\.dsh\profiles\web\cordis.patch.yml` | dsh 侧 trustedHosts 白名单（持久化）|
| `C:\Users\yashi\.dsh\web-3081.log` | dsh web 运行日志（含认证 token）|
