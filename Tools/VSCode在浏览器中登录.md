# VSCode登录 在浏览器中登录

1.140 起 Microsoft 账号登录默认走 Windows 原生账号代理（WAM），弹出的是内置账号选择窗口。改回外置浏览器登录：

## 设置

```jsonc
// Code\User\settings.json
// 新版已删除 classic 实现，只能取 msal / msal-no-broker
"microsoft-authentication.implementation": "msal-no-broker"
```

GUI：`Ctrl+,` → 搜索 `microsoft-authentication implementation` → 下拉框由 `msal` 改为 `msal-no-broker`。

| 取值 | 行为 |
| --- | --- |
| `msal`（默认） | 使用 MSAL，走 Windows 原生账号代理 WAM（内置窗口） |
| `msal-no-broker` | 使用 MSAL，通过外置浏览器登录；官方说明为出现 native broker 问题时使用 |

## 改完必须重载窗口

扩展监听了配置变更，会弹出模态框 `Reload required / Microsoft Account configuration has been changed.`，点 Reload。
也可 `Ctrl+Shift+P` → `Developer: Reload Window`。

重载后需先退出当前 Microsoft 账号再重新登录，才会走浏览器。

## 注意

- 该设置带 `onExP` 标签，属实验性设置，可能出现在 Settings 的 Experimental 分类。
- Remote-SSH / WSL / Dev Containers：`msal-no-broker` 走协议回调（`https://vscode.dev/redirect`），比回环端口更适合远程场景，本地回环端口在远程主机上收不到回调。
- 改了仍弹内置窗口：说明 Windows 侧仍有已登录的 Microsoft 账号，到「Windows 设置 → 账户 → 电子邮件和账户」移除账号，或先在 VS Code 里对 Microsoft 账号执行 sign out 再重登。
- 网上让改成 `"classic"` 的老教程在 1.140 上已失效，无效值会被忽略（代码里 `classic` 已无任何引用）。

## 本机验证方式

在安装目录下读取设置定义，确认当前版本支持的取值：

```powershell
# 查看实现方式的枚举定义
$p = "C:\Program Files\Microsoft VS Code\07f806f999\resources\app\extensions\microsoft-authentication\package.json"
(Get-Content $p -Raw | ConvertFrom-Json).contributes.configuration.properties.'microsoft-authentication.implementation'
```

```powershell
# 搜索实现相关的取值（classic 应搜不到，msal-no-broker 应有结果）
Get-ChildItem "C:\Program Files\Microsoft VS Code\07f806f999\resources\app" -Recurse -File |
  Where-Object { $_.Length -lt 100MB -and $_.Extension -in @('.js','.json') } |
  Select-String -Pattern 'msal-no-broker' -List
```

## 出处

- https://github.com/microsoft/vscode/issues/239648 （Microsoft auth window opens behind Edge browser window）
- 本机 VS Code 1.140.0 安装目录 `extensions\microsoft-authentication` 的 `package.json` / `package.nls.json` / `dist\extension.js` 实测
