# 在 Termux 中运行 DeepSeek Harness（Web 版）

## 命令速查（置顶）

日常使用（Termux 端）：

```bash
bash ~/start-dsh.sh      # 启动 DSH Web（监听 127.0.0.1:3080）
tail ~/dsh-web.log       # 查看启动日志
pkill -f "bin.js web"    # 停止
```

电脑端访问：

```powershell
adb forward tcp:13080 tcp:3080        # USB 通道 → 浏览器开 http://127.0.0.1:13080
ssh -L 13081:127.0.0.1:3080 termuxu   # SSH 隧道 → 浏览器开 http://127.0.0.1:13081
```

手机浏览器直接开 `http://127.0.0.1:3080`。

首次安装（Termux 端，完整命令序列）：

```bash
# 手机 DNS 解析异常时先走局域网代理
export http_proxy=http://192.168.2.200:23334 https_proxy=http://192.168.2.200:23334
# 1. 编译工具链
pkg install -y clang make python binutils
# 2. 全局安装（版本必须钉 0.1.0-rc.6）
npm install -g @deepseek-ai/dsh --ignore-scripts
npm install -g @deepseek-ai/dsh-web-app@0.1.0-rc.6 --ignore-scripts
termux-fix-shebang /data/data/com.termux/files/usr/bin/dsh
# 3. profile 依赖（必须装在 profile 自己的 node_modules 里）
cd ~/.dsh/profiles/web && npm install @deepseek-ai/dsh-base@0.1.0-rc.6 @deepseek-ai/dsh-web-app@0.1.0-rc.6 --ignore-scripts
# 4. 修 gyp 的 android 分支（一次性；Node 头缓存被重装后需重做）
sed -i "s/'OS == \"android\"'/'OS == \"android-off\"'/" ~/.cache/node-gyp/26.3.1/include/node/common.gypi
# 5. 编译 node-pty
cd ~/.dsh/profiles/web/node_modules/node-pty && CC=clang CXX=clang++ node /data/data/com.termux/files/usr/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js rebuild
# 6. 构建 koffi
cd ~/.dsh/profiles/web/node_modules/koffi && node ./cnoke.cjs -P . -D src/koffi --prebuild --release
# 7. sharp 用 WASM 版（--save 防被 npm 修剪）
cd ~/.dsh/profiles/web && npm install @img/sharp-wasm32 --save --ignore-scripts
# 8. 经 SSH 部署的文件缺应用 SELinux 类别，手机端直接运行前必须重打标签（见踩坑记录）
su -c 'chcon -R -h u:object_r:app_data_file:s0:c60,c257,c512,c768 ~/.dsh ~/start-dsh.sh ~/dsh-web.log'
```

## 背景与结论

- 目标：让 DeepSeek Harness（`@deepseek-ai/dsh`）跑在手机 Termux 里，手机浏览器或电脑浏览器直接使用。
- 本机实测结论：**完全可行**。手机（Xiaomi 2505APX7BC / HyperOS，Termux Play 版，8 核 / 10G 内存 / Node 26.3.1）已成功启动 `dsh web` 并正常服务（HTTP 200、API 正常）。
- 前置依赖：Termux 已配好 SSH（见《Termux电脑SSH连接.md》），全部操作经 `ssh termuxu`（USB 转发）完成。
- 版本对齐很重要：`dsh`、`dsh-base`、`dsh-web-app` 全部固定 **0.1.0-rc.6**（与电脑一致；最新版 dsh-web-app 依赖未发布的 `dsh-bash-env` 包会 404）。

## 安装步骤（全部实测通过）

### 1. 编译工具链（node-pty 等原生模块要源码编译）

```bash
# 手机 DNS 解析 termux.net 会失败，全程走局域网代理
export http_proxy=http://192.168.2.200:23334 https_proxy=http://192.168.2.200:23334
pkg install -y clang make python binutils
```

### 2. 全局安装 dsh 与 dsh-web-app（跳过安装脚本，原生模块后面手动处理）

```bash
npm install -g @deepseek-ai/dsh --ignore-scripts
npm install -g @deepseek-ai/dsh-web-app@0.1.0-rc.6 --ignore-scripts
termux-fix-shebang /data/data/com.termux/files/usr/bin/dsh   # 修复 /usr/bin/env 坏解释器
```

### 3. 给 web profile 装 bundle 依赖（关键！）

dsh web 默认 profile 的 bundles 是 `dsh-base` + `dsh-web-app`，**必须装在 profile 自己的 node_modules 里**，否则 bundle 的 cordis 补丁（如「禁用 HMR」）不生效、loader 回退成哈希 id 自动组合：

```bash
cd ~/.dsh/profiles/web
npm install @deepseek-ai/dsh-base@0.1.0-rc.6 @deepseek-ai/dsh-web-app@0.1.0-rc.6 --ignore-scripts
```

### 4. 三个原生模块

```bash
# ① 先修 gyp：Node 26 在 Termux 上 process.platform=android，gyp 走 NDK 分支报错
#    改 Node 头缓存里的 common.gypi，禁用引用 android_ndk_path 的条件
sed -i "s/'OS == \"android\"'/'OS == \"android-off\"'/" ~/.cache/node-gyp/26.3.1/include/node/common.gypi

# ② node-pty：源码编译
cd ~/.dsh/profiles/web/node_modules/node-pty
CC=clang CXX=clang++ node /data/data/com.termux/files/usr/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js rebuild

# ③ koffi：跑它自带的构建脚本（自动编 android_arm64）
cd ~/.dsh/profiles/web/node_modules/koffi
node ./cnoke.cjs -P . -D src/koffi --prebuild --release

# ④ sharp：无 Android 预编译，Termux libvips 又没 C++ 绑定 → 用官方 WASM 版
cd ~/.dsh/profiles/web
npm install @img/sharp-wasm32 --no-save --ignore-scripts
```

### 5. 配置与启动脚本

`~/.dsh/settings.yaml`：

```yaml
agent-default-model:
  provider: deepseek-official
  model: deepseek-v4-pro
  reasoningEffort: max
```

`~/start-dsh.sh`（权限 600，必须 LF 换行；密钥从电脑用户环境变量复制，此处省略）：

```bash
#!/data/data/com.termux/files/usr/bin/bash
export DEEPSEEK_API_KEY='...'
export PATH=/data/data/com.termux/files/usr/bin:$PATH
cd ~
nohup node --expose-internals /data/data/com.termux/files/usr/lib/node_modules/@deepseek-ai/dsh/lib/bin.js web >> ~/dsh-web.log 2>&1 &
```

启动：`bash ~/start-dsh.sh`，日志 `~/dsh-web.log`。

### 6. 访问方式

- 手机浏览器直接访问：`http://127.0.0.1:3080`
- 电脑浏览器（USB 转发，13080 避开电脑自身 dsh 的 3080）：

```powershell
adb forward tcp:13080 tcp:3080
# 然后访问 http://127.0.0.1:13080
```

## 踩坑记录

| 现象 | 原因 | 解决 |
| --- | --- | --- |
| node-pty 编译报 `Undefined variable android_ndk_path in binding.gyp` | Node 26 在 Termux 上 `process.platform=android`，Node 自带 gyp 凭 `__ANDROID__` 宏判定 android，触发 common.gypi 的 NDK 分支 | 把 Node 头缓存 `common.gypi` 里 `'OS == "android"'` 改成 `android-off` 再编译 |
| 启动报 `--expose-internals is required for HMR service`（条目是哈希 id） | 两层原因：① profile 目录缺 node_modules，dsh-web-app 的「禁用 HMR」补丁未生效，boot 回退创建原生 HMR；② 手机没有 `node-addon-require-builtin` 原生插件（电脑靠它免开关访问 Node 内部） | ① 在 profile 内安装 dsh-base+dsh-web-app；② 用 `node --expose-internals` 直接启动 bin.js（**NODE_OPTIONS 不允许放该开关**） |
| sharp 加载报 `Could not load the "sharp" module using the android-arm64 runtime` | 无 Android 预编译；Termux 的 libvips 不带 C++ 绑定（vips-cpp） | 安装 `@img/sharp-wasm32`（必须装到 profile 根 node_modules，与 sharp 平级，嵌套安装 ESM 解析不到） |
| `dsh: /usr/bin/env: bad interpreter` | npm 生成的 shim 用 `#!/usr/bin/env`，Termux 没有 /usr/bin/env | `termux-fix-shebang` |
| `npm install -g @deepseek-ai/dsh-web-app` 报 404（`@deepseek-ai/dsh-bash-env` 不存在） | 默认装了最新版，其依赖树引用了未发布包 | 固定 `@0.1.0-rc.6` |
| 启动脚本报 `$'\r'` 错误 | Windows 生成脚本是 CRLF | 脚本必须 LF（密钥值里的 \r 也会破坏 API 认证） |
| `dsh web --host 0.0.0.0` 报 `intentionally not supported yet for safety` | **官方刻意禁止**局域网绑定（= 暴露远程代码执行面）；`remote-web-ui` 配对插件同样要求 0.0.0.0 或公网隧道（cloudflared 无 Android 二进制） | 局域网直连不可行；用 USB 转发（电脑 `http://127.0.0.1:13080`）或 SSH 隧道（`ssh -L 13081:127.0.0.1:3080 termuxu`） |
| sharp 在 profile 里装其他插件后重新报 android-arm64 加载失败 | `--no-save` 装的 `@img/sharp-wasm32` 被 npm 当「多余包」修剪 | 用 `--save` 写进 profile dependencies，npm 后续操作会保留 |
| 手机端直接运行报 `EACCES: permission denied, readlink '~/.dsh/profiles/node_modules/@deepseek-ai/dsh'` | 经 SSH（magisk 域）创建的文件只带 `app_data_file:s0`，**缺应用专属 MLS 类别**（c60,c257,c512,c768）；Android 策略要求类别精确匹配，Termux 应用（untrusted_app）读不了 | `su -c 'chcon -R -h u:object_r:app_data_file:s0:c60,c257,c512,c768 ~/.dsh ~/start-dsh.sh ~/dsh-web.log'`。注意 `restorecon` 无效（恢复不出类别）；以后每次经 SSH 改 ~/.dsh 都要重跑此命令 |

## 日常维护

- 重启：`bash ~/start-dsh.sh`；看日志 `tail ~/dsh-web.log`。
- 手机深睡冻结：已加 Doze 白名单（`dumpsys deviceidle whitelist +com.termux`，见 SSH 篇）。
- **经 SSH 改过 ~/.dsh 里的文件后**：重跑 `su -c 'chcon -R -h u:object_r:app_data_file:s0:c60,c257,c512,c768 ~/.dsh ~/start-dsh.sh ~/dsh-web.log'`，否则手机端直接运行会 EACCES。
- 版本升级：改 npm 版本时注意 dsh / dsh-base / dsh-web-app 三者版本对齐，并重做第 3、4 步。
- 密钥以明文存于 `~/start-dsh.sh`（600 权限），与 dsh-ssh 插件同一信任模型，勿提交公开仓库。
