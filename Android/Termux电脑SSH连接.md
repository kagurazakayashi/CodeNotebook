# 从电脑 SSH 连接 Termux（SSH over USB / 局域网）

## 命令速查（置顶）

电脑端（PowerShell）：

```powershell
# ── 密钥（生成一次即可；勿用 ed25519，手机 sshd 认证会崩） ──
ssh-keygen -t rsa -b 3072 -f $HOME\.ssh\id_rsa_termux
ssh-keygen -R "[192.168.2.201]:8022"    # 报 Host key verification failed 时清旧主机密钥

# ── USB 通道（必须用 forward，不是 reverse！重插 USB 后重跑） ──
adb forward tcp:8022 tcp:8022
ssh termuxu

# ── 局域网直连（手机休眠时先唤醒屏幕） ──
ssh termux

# ── 重启手机 sshd（手机重启/进程消失后执行） ──
adb shell su 10316 -c /data/data/com.termux/files/usr/bin/start-sshd-pc

# ── SSH 隧道访问手机 DSH（浏览器开 http://127.0.0.1:13081） ──
ssh -L 13081:127.0.0.1:3080 termuxu
```

Termux 端（首次配置时执行过一次）：

```bash
# 手机 DNS 解析异常时先走局域网代理
export http_proxy=http://192.168.2.200:23334 https_proxy=http://192.168.2.200:23334
pkg install -y openssh
```

## 背景与结论

- 在《Termux电脑执行命令.md》基础上配置 SSH，实现从电脑完整交互式连接 Termux（推荐方案）。
- 本机实测结论：**「局域网直连 + RSA 公钥认证」与「USB 端口转发（adb forward）」两条链路均完全成功**。
- 环境：Windows 11（OpenSSH 9.5 客户端）；手机 Xiaomi 2505APX7BC / HyperOS，已 root（Magisk），Termux 为 Play 版，应用 uid 10316。
- 四个关键坑（详见「踩坑记录」）：
  1. 手机端 apt 解析 termux.net 失败，装包必须走局域网代理。
  2. **ed25519 公钥会让 sshd-auth 子进程崩溃（exit 255），必须用 RSA 公钥。**
  3. Play 版 Termux 没有 RUN_COMMAND 服务组件，无法用 `am startservice` 以应用上下文启动 sshd；`su -Z` 切换 SELinux 域也被 HyperOS 策略拒绝。实测经 Magisk su 启动的 sshd（magisk 域）可正常使用。
  4. **USB 连接必须用 `adb forward` 而不是 `adb reverse`**：reverse 是「手机监听 → 转发到电脑」，方向与 SSH 需求相反；且 reverse 要在手机上绑定端口，会与 sshd 占用的 8022 冲突报 `Address already in use`。forward 才是「电脑监听 → 转发到手机」。
  5. HyperOS 深睡会冻结 Termux 进程（sshd 无响应、adb shell 卡死），需把 Termux 加入 Doze 白名单。

## 完整配置步骤

### 1. 安装 openssh（手机 DNS 异常时走局域网代理）

脚本推送法（同《Termux电脑执行命令.md》），脚本内容：

```bash
#!/data/data/com.termux/files/usr/bin/bash
export PREFIX=/data/data/com.termux/files/usr
export HOME=/data/data/com.termux/files/home
export PATH=$PREFIX/bin:$PREFIX/bin/applets
export LD_LIBRARY_PATH=$PREFIX/lib
export TMPDIR=$PREFIX/tmp
. $PREFIX/etc/profile

# 手机本地 DNS 解析 termux.net 失败，经局域网代理下载（代理端负责解析）
export http_proxy=http://192.168.2.200:23334
export https_proxy=http://192.168.2.200:23334

pkg install -y openssh
```

执行：

```powershell
adb push 脚本.sh /data/local/tmp/termux-install-ssh.sh
adb shell su 10316 -c /data/data/com.termux/files/usr/bin/bash /data/local/tmp/termux-install-ssh.sh
```

安装时会自动生成 RSA/ECDSA/ED25519 三套 host keys。

### 2. 电脑生成 RSA 密钥（不要用 ed25519）

```powershell
ssh-keygen -t rsa -b 3072 -f $HOME\.ssh\id_rsa_termux
```

### 3. 部署公钥到手机

```powershell
adb push $HOME\.ssh\id_rsa_termux.pub /data/local/tmp/ak.pub
adb shell su -c cp /data/local/tmp/ak.pub /data/data/com.termux/files/home/.ssh/authorized_keys
adb shell su -c chown 10316:10316 /data/data/com.termux/files/home/.ssh/authorized_keys
adb shell su -c chmod 600 /data/data/com.termux/files/home/.ssh/authorized_keys
adb shell su -c rm /data/local/tmp/ak.pub
```

### 4. 启动 sshd（电脑侧）

手机已安装自包含启动脚本 `/data/data/com.termux/files/usr/bin/start-sshd-pc`，一条命令重启：

```powershell
adb shell su 10316 -c /data/data/com.termux/files/usr/bin/start-sshd-pc
```

脚本内容（可重装，须 LF 换行）：

```bash
#!/data/data/com.termux/files/usr/bin/bash
# 从电脑重启 Termux sshd 的自包含脚本（由 su 以 10316 执行）
export PREFIX=/data/data/com.termux/files/usr
export HOME=/data/data/com.termux/files/home
export PATH=$PREFIX/bin:$PREFIX/bin/applets
export LD_LIBRARY_PATH=$PREFIX/lib
export TMPDIR=$PREFIX/tmp
. $PREFIX/etc/profile
pkill sshd 2>/dev/null
sleep 1
sshd
echo "sshd restarted"
```

### 5. 电脑端 SSH 配置与连接

`~/.ssh/config` 追加（本机已配置）：

```
Host termux
    HostName 192.168.2.201
    Port 8022
    User yashi
    IdentitiesOnly yes
    IdentityFile C:/Users/yashi/.ssh/id_rsa_termux

Host termuxu
    HostName 127.0.0.1
    Port 8022
    User yashi
    IdentitiesOnly yes
    IdentityFile C:/Users/yashi/.ssh/id_rsa_termux
```

连接方式：

```powershell
# 方式 A：局域网直连（电脑手机同一 WiFi，已实测成功）
ssh termux

# 方式 B：USB 端口转发（电脑监听 8022 经 USB 转发到手机，已实测成功）
adb forward tcp:8022 tcp:8022
ssh termuxu
```

### 6. 验证结果

```powershell
ssh termux "uname -m; pkg list-installed | wc -l"
# aarch64
# 99
```

## 踩坑记录

| 现象 | 原因 | 解决 |
| --- | --- | --- |
| `pkg install` 报 `Something wicked happened resolving 'termux.net:https'` | 手机端 DNS 解析 termux.net 返回空（ping 却通，属 netd 解析链路问题） | 安装脚本加 `http_proxy`/`https_proxy` 环境变量走局域网代理 |
| ed25519 密钥 SSH 报 `Permission denied`，服务端日志 `Connection reset by authenticating user ... [preauth]`，调试日志在 `Postponed publickey` 后 sshd-auth 子进程 exit 255 | 本机 Termux（Play 版，OpenSSH 10.3 / OpenSSL 3.6.1）处理 ed25519 签名的兼容性问题（根因未找到官方记录） | 改用 RSA 公钥，authorized_keys 里不要留 ed25519 |
| `su -Z u:r:untrusted_app...` 报 `Cannot execute /system/bin/sh: Permission denied` | HyperOS SELinux 策略不允许 untrusted_app 域对 shell_exec/bash 的 entrypoint 转换 | 放弃 -Z，直接用 magisk 域启动 sshd（实测可用） |
| `pm grant ... com.termux.permission.RUN_COMMAND` 报 Unknown permission；`am startservice -n com.termux/.app.RunCommandService` 报 Not found | Play 版 Termux 精简了 RUN_COMMAND 服务组件 | 改用 su 启动 sshd |
| `adb reverse tcp:8022 tcp:8022` 报 `cannot bind listener: Address already in use` | **方向搞反了**：reverse 是手机端监听并转发到电脑（用于手机访问电脑服务），绑定发生在手机上，与 sshd 占用的 8022 冲突 | SSH 场景改用 `adb forward tcp:8022 tcp:8022`（电脑监听 → 转发到手机） |
| 手机休眠后 SSH/`adb shell` 无响应或超时（手机→电脑 ping 通、电脑→手机不通） | HyperOS 深睡冻结 Termux 进程，sshd 不响应 | `adb shell su -c dumpsys deviceidle whitelist +com.termux` 加白名单（本机已设）；连接前唤醒屏幕 |
| `ssh` 报 `Host key verification failed` | known_hosts 里存了旧主机密钥类型 | `ssh-keygen -R "[192.168.2.201]:8022"` 后重连 |

## 日常维护

- 手机重启 / 重插 USB 后：`adb forward` 失效需重跑（`adb forward tcp:8022 tcp:8022`）；sshd 不在了就重跑 `start-sshd-pc`。
- 手机 IP 变化：`adb shell ip addr show wlan0` 查新 IP，更新 `~/.ssh/config` 的 HostName 与 `~/.dsh/dsh-ssh.json`。
- 手机深睡冻结 Termux：已加 Doze 白名单；若仍超时，唤醒屏幕后重试。
- 密钥过期/换电脑：重做第 2、3 步即可（RSA 类型！）。

## 接入 DeepSeek Harness SSH 插件（dsh-ssh）

DSH Web GUI 安装了 `@linxin666/dsh-ssh` 插件（侧边栏「SSH」面板）。主机配置存于 `~/.dsh/dsh-ssh.json`（version 1，本机已配置两台主机，均用 `id_rsa_termux` 密钥）：

```json
{
  "version": 1,
  "hosts": [
    { "alias": "termux",  "host": "192.168.2.201", "port": 8022, "user": "yashi",
      "auth": { "kind": "key", "keyPath": "C:/Users/yashi/.ssh/id_rsa_termux" },
      "proxyJump": [], "tags": ["android", "termux", "phone"] },
    { "alias": "termuxu", "host": "127.0.0.1", "port": 8022, "user": "yashi",
      "auth": { "kind": "key", "keyPath": "C:/Users/yashi/.ssh/id_rsa_termux" },
      "proxyJump": [], "tags": ["android", "termux", "phone", "usb"] }
  ]
}
```

要点：

- `termux` 走局域网；`termuxu` 走 USB（需先 `adb forward tcp:8022 tcp:8022`）。已用插件同款 ssh2 库实测连接并执行命令成功。
- 插件安装后需重启 `dsh web` 才会挂载 `/api/dsh-ssh/*` 路由（重启前接口返回 404）。
- **后端总开关在 `~/.dsh/settings.yaml` 的 `dsh-ssh.enabled`**（默认 true；若为 false，侧边栏入口仍在但接口 404）。settings 文件被 chokidar 监听，直接改文件即热生效，无需重启。
- 插件命名空间不在 Web 设置 API 白名单内（`/api/settings.update` 报 settings-not-exposed），改配置直接编辑 settings.yaml。
- 插件自身支持从 `~/.ssh/config` 一键导入；本机两个别名已存在于 ssh config，导入时会自动跳过（alias 冲突），不会重复。
- 连接方式：GUI「SSH」面板直接选主机连终端；或让 Agent 用 `ssh_exec`/`ssh_upload` 等工具。

## 来源

- Termux Wiki: Remote Access — https://wiki.termux.com/wiki/Remote_Access
- termux/termux-app issue #2641（Termux 公钥连接问题的旁证） — https://github.com/termux/termux-app/issues/2641
- ed25519 崩溃问题未找到官方记录，为实测发现并绕过（2026-08-15，Termux Play 版 openssh 10.3p1）
