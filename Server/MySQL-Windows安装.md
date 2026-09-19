# MySQL 8 Windows 安装（MSI + GUI 配置）

## 下载

从 [MySQL 官方下载页](https://dev.mysql.com/downloads/installer/) 获取 `mysql-installer-community-8.x.x.msi`。一般选体积较大的完整版（含所有组件），也可选体积较小的 web 版（安装时在线下载）。

## 安装流程

双击 msi 启动 MySQL Installer，按向导操作：

### 1. 选择安装类型

| 选项 | 说明 |
|------|------|
| Developer Default | 开发环境全套（MySQL Server + Workbench + Shell + Connectors），**推荐** |
| Server only | 仅安装 MySQL Server |
| Client only | 仅安装客户端工具 |
| Full | 安装所有组件 |
| Custom | 自定义选择组件 |

### 2. 检查依赖

安装程序会列出缺少的依赖（如 Visual C++ Redistributable），点击 **Execute** 自动安装。

### 3. 安装

点击 **Execute** 开始安装所选组件，完成后点 **Next** 进入配置阶段。

### 4. 产品配置 —— Type and Networking

- **Config Type**：一般选 **Development Computer**（占用内存较少）。Server Computer / Dedicated Computer 会分配更多内存。
- **Connectivity**：默认勾选 TCP/IP，端口 `3306`。如需远程访问，勾选 **Open Windows Firewall ports for network access**。
- **Named Pipe / Shared Memory**：一般不需要勾选。

### 5. 产品配置 —— Authentication Method

MySQL 8 默认使用 `caching_sha2_password`。如果使用较老的客户端（如 PHP 5.x、旧版 Navicat），必须切换为：

- **Use Legacy Authentication Method (Retain MySQL 5.x Compatibility)**，即 `mysql_native_password`

> 后续可通过 SQL 手动改回：`ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY '密码';`

### 6. 产品配置 —— Accounts and Roles

- 设置 **root 密码**（务必牢记）。
- 可在此处添加额外的数据库用户（也可安装后通过 SQL 添加）。

### 7. ★ 产品配置 —— Windows Service（重要）

此处配置 MySQL 以 Windows 服务方式运行，也是最容易出权限问题的地方：

| 选项 | 说明 |
|------|------|
| **Configure MySQL Server as a Windows Service** | 勾选（默认） |
| **Windows Service Name** | 默认 `MySQL80`，可自定义 |
| **Start the MySQL Server at System Startup** | 建议勾选，开机自启 |
| **Run Windows Service as...** | 见下方详细说明 |

#### 服务运行账户

GUI 提供三种选项：

**① Standard System Account（默认，Network Service）**

- 权限最低，最安全。
- 对系统大部分目录没有写入权限。
- **问题**：如果自定义数据目录（datadir）放在非默认位置，必须手动为 `NT SERVICE\MySQL80`（服务名）添加该目录的 **完全控制** NTFS 权限（见下方"自定义数据目录"章节）。
- **问题**：在域控制器上，Network Service 实际是域机器账户，可能导致认证问题。

**② Custom User**

- 指定一个本地或域用户来运行 MySQL 服务。
- 适用场景：需要访问网络共享存储、域环境下的统一管理。

> **注意**：安装程序仅会自动授予"作为服务登录"权限，但自定义用户实际上还需要多项本地安全策略权限才能正常运行。如果安装程序授权不全（常有的事），需手动配置。详见下方 ★ 自定义用户的本地安全策略配置。

**③ Local System Account（不推荐）**

- 权限极高，可访问几乎所有本地资源。
- **安全隐患**：如果 MySQL 被攻破，攻击者可获得 SYSTEM 级权限。
- 官方不推荐用于生产环境。

> **推荐**：使用默认的 **Standard System Account (Network Service)**，然后用下方方法处理好数据目录权限。

### 8. 产品配置 —— Server File Permissions

此步骤设定服务账户对数据目录的文件系统权限，会弹出三个选项：

| 选项 | 效果 | 适用场景 |
|------|------|----------|
| **Yes, grant full access to the user running the Windows Service (if applicable) and the administrators group only. Other users and groups will not have access.** | 自动给**服务运行账户** + **Administrators 组**授予数据目录的完全控制权限，同时**移除**其他所有用户/组的访问权限。 | **推荐**，最安全，装完即用。 |
| **Yes, but let me review and configure the level of access.** | 弹出一个类似资源管理器"安全"选项卡的界面，手动勾选各用户/组的权限。 | 需要精细控制时使用（如额外给备份账户只读权限）。不熟悉 NTFS 权限模型容易漏设。 |
| **No, I will manage the permissions after the server configuration.** | 跳过此步骤，不修改任何文件夹权限。 | 仅当数据目录已有正确的权限设置时选用。选这个大概率服务起不来，事后仍需用 `icacls` 手动设权限。 |

> 默认为第一个选项。如果使用了自定义数据目录且不在安装阶段指定，此步骤无法覆盖——需安装后手动配置 NTFS 权限（见下方 ★ 自定义数据目录）。

### 9. 产品配置 —— Sample Databases

可选步骤，展示两个 MySQL 官方示例数据库：

| 数据库 | 说明 |
|--------|------|
| **Sakila** | 模拟 DVD 租赁店，表结构较复杂（film、actor、customer、rental、payment 等），含视图、存储过程、触发器，适合练习复杂查询。 |
| **World** | 仅三张表（country、city、countrylanguage），结构简单，适合入门 SQL 练习。 |

- 两者**不勾选也完全不影响 MySQL 正常使用**，纯用于学习测试。
- 勾选后 MySQL Configurator 会自动创建对应库和表并填充示例数据。

### 10. 产品配置 —— Apply Configuration

点击 **Execute** 应用上述配置，MySQL 服务将被创建并启动。

> **常见失败**：日志中显示 `Adding new service` 后报 `句柄无效`。这是因为之前卸载残留的服务处于"标记删除"状态。除了重启电脑外，可用命令行手动安装服务绕过：
>
> ```batch
> cd /d "%ProgramFiles%\MySQL\MySQL Server 9.7\bin"
> mysqld --install "MySQL97" --defaults-file="%ProgramFiles%\MySQL\MySQL Server 9.7\my.ini"
> ```
>
> 执行后 `net start MySQL97` 即可启动。路径中版本号按实际情况调整。
>
> **如果服务读取的 my.ini 不正确**（如指向了错误的数据目录），需先删除服务再重建，重新指定 `--defaults-file`：
>
> ```batch
> sc delete MySQL97
> mysqld --install "MySQL97" --defaults-file="D:\MySQLData\MySQL\MySQL Server 9.7\my.ini"
> net start MySQL97
> ```
>
> **如果服务读取的 my.ini 不正确**（如指向了错误的数据目录），需先删除服务再重建，重新指定 `--defaults-file`：
>
> ```batch
> sc delete MySQL97
> mysqld --install "MySQL97" --defaults-file="D:\MySQLData\MySQL\MySQL Server 9.7\my.ini"
> net start MySQL97
> ```

---

## ★ 自定义数据目录（datadir）

### 场景

默认数据目录在 `C:\ProgramData\MySQL\MySQL Server 8.0\Data\`。当 C 盘空间不足或需要数据独立存放时，需将其移到其他盘（如 `D:\MySQLData`）。

### 关键操作步骤

#### 第一步：停止服务

```powershell
net stop MySQL80
```

#### 第二步：复制原数据

```powershell
# 注意保留权限
robocopy "C:\ProgramData\MySQL\MySQL Server 8.0\Data" D:\MySQLData /E /COPYALL /DCOPY:T
```

> `/COPYALL` 确保复制 NTFS 权限。如果失败，改用普通复制后再手动设权限。

#### 第三步：修改 my.ini

`my.ini` 通常位于 `C:\ProgramData\MySQL\MySQL Server 8.0\my.ini`，修改：

```ini
# 将原来的
datadir=C:/ProgramData/MySQL/MySQL Server 8.0/Data

# 改为
datadir=D:/MySQLData
```

> 注意路径使用正斜杠 `/` 或双反斜杠 `\\`。

#### 第四步：★ 设置 NTFS 权限（最容易遗漏）

打开 PowerShell **以管理员身份运行**，执行：

```powershell
# 查看当前服务对应的 SID（服务账户名格式为 NT SERVICE\MySQL80）
# 如果服务名不同，对应修改

# 方法一：使用 icacls
icacls "D:\MySQLData" /grant "NT SERVICE\MySQL80:(OI)(CI)F" /T

# 方法二：如果 MySQL 使用 NETWORK SERVICE 账户
icacls "D:\MySQLData" /grant "NETWORK SERVICE:(OI)(CI)F" /T

# 查看当前权限
icacls "D:\MySQLData"
```

> 参数说明：
> - `(OI)` — 对象继承：子文件继承此权限
> - `(CI)` — 容器继承：子文件夹继承此权限
> - `F` — 完全控制（Full Control）

**如果没有正确设置权限，MySQL 服务启动时会报错**：
- `InnoDB: Operating system error number 5 in a file operation`（拒绝访问）
- Windows 事件查看器中显示 "Access denied for data directory"

#### 第五步：启动服务

```powershell
net start MySQL80
```

### 验证数据目录

登录 MySQL 后执行：

```sql
SHOW VARIABLES LIKE 'datadir';
```

---

## ★ 不同用户运行 MySQL 的权限与策略问题

### 服务账户的身份

MySQL Windows 服务默认使用 `NT SERVICE\MySQL80`（虚拟账户），它属于 Network Service 组。在不同 Windows 环境下，这个账户的实际身份会有差异：

| 环境 | 服务账户身份 | 可能的问题 |
|------|-------------|-----------|
| 独立工作站 | `NT SERVICE\MySQL80` | 对本地资源访问正常 |
| 加入域的工作站 | 同上，但认证时使用机器账户 `DOMAIN\COMPUTERNAME$` | 访问网络资源时需用机器账户授权 |
| 域控制器 | **不存在本地 NT SERVICE 账户**，会转为 Network Service | 认证和权限表现不同 |
| 使用 Local System | `NT AUTHORITY\SYSTEM` | 权限极大，安全风险高 |

### 常见权限问题与解决

**问题1：自定义数据目录后 MySQL 无法启动**

- 原因：新目录缺少服务账户的完全控制权限。
- 解决：用 `icacls` 授予权限（见上方）。

**问题2：LOAD DATA INFILE 或 SELECT INTO OUTFILE 失败**

```sql
-- 错误：Can't create/write to file (OS errno 13 - Permission denied)
```

- 原因：目标目录对服务账户无写入权限，且 MySQL 8 默认 `secure_file_priv` 有限制。
- 解决：在 `my.ini` 中设置 `secure-file-priv="D:/MySQLExports"` 并为该目录赋予服务账户写入权限。

**问题3：服务安装后状态为"启动后停止"**

- 原因通常是数据目录权限不足或 `my.ini` 中 `datadir` 路径不存在。
- 检查 Windows 事件查看器 → Windows 日志 → 应用程序，查找 MySQL 相关错误。

## ★ 自定义用户的本地安全策略配置

使用 Custom User 运行 MySQL 服务时，该用户需要多项本地安全策略权限。MySQL 安装程序仅会自动授予"作为服务登录"，其余需手动配置。

### 所需的本地安全策略

打开 `secpol.msc`（本地安全策略）→ 安全设置 → 本地策略 → 用户权限分配：

| 策略名称（中文） | 策略名称（英文） | 必要程度 | 说明 |
|---|---|---|---|
| 作为服务登录 | Log on as a service | **必须** | 允许用户以服务形式运行进程 |
| 替换一个进程级令牌 | Replace a process level token | **推荐** | MySQL 某些子进程需要此权限 |
| 为进程调整内存配额 | Adjust memory quotas for a process | **推荐** | 允许 MySQL 调整内存使用 |
| 绕过遍历检查 | Bypass traverse checking | 可选 | 访问多层目录时避免逐个检查权限 |
| 作为批处理作业登录 | Log on as a batch job | 可选 | 部分计划任务场景需要 |

### GUI 配置方式

1. `Win + R` → 输入 `secpol.msc` → 确定
2. 导航到 **本地策略** → **用户权限分配**
3. 双击目标策略 → **添加用户或组** → 输入用户名（如 `.\mysql_user`）→ **检查名称** → 确定
4. 重启或运行 `gpupdate /force` 使策略立即生效

### 命令行配置方式

以下 PowerShell 脚本需以管理员身份运行，可一次性导出 / 导入策略：

```powershell
# 安装 secedit 策略导出工具模块（仅首次需要）
# 以下用命令行方式逐个授予权限

# 假设自定义用户名为 mysql_user，根据实际修改

# 方法一：使用 ntrights.exe（需从 Windows Server Resource Kit 获取）
# ntrights +r SeServiceLogonRight -u ".\mysql_user"
# ntrights +r SeAssignPrimaryTokenPrivilege -u ".\mysql_user"
# ntrights +r SeIncreaseQuotaPrivilege -u ".\mysql_user"

# 方法二：使用 PowerShell 调用 secedit 配置（推荐）
# 1. 导出当前安全模板
secedit /export /cfg C:\temp\secpol.inf

# 2. 手动编辑 C:\temp\secpol.inf，在 [Privilege Rights] 段中找到对应策略
#    将用户名追加到对应策略的值中（用逗号分隔）
#    SeServiceLogonRight = *S-1-5-80-...,.\mysql_user
#    SeAssignPrimaryTokenPrivilege = *S-1-5-19,...,.\mysql_user
#    SeIncreaseQuotaPrivilege = *S-1-5-19,...,.\mysql_user

# 3. 导入修改后的安全模板
secedit /configure /db C:\windows\security\local.sdb /cfg C:\temp\secpol.inf /areas USER_RIGHTS

# 4. 强制刷新组策略
gpupdate /force
```

### 验证策略是否生效

```powershell
# 查看当前已授予"作为服务登录"权限的所有账户
secedit /export /cfg C:\temp\check.inf
Select-String -Path "C:\temp\check.inf" -Pattern "SeServiceLogonRight"
```

### 验证自定义用户是否能启动 MySQL

```powershell
# 确保服务指向正确的用户
# 打开 services.msc → 找到 MySQL80 → 属性 → 登录 → 此账户 → 输入用户名密码

# 或使用 sc 命令
sc config MySQL80 obj= ".\mysql_user" password= "用户密码"
net start MySQL80
```

### 安全最佳实践

1. **永远不要用 Administrator 账户运行 MySQL 服务**。
2. 生产环境使用 **Network Service** 或专用的**低权限域账户**。
3. 数据目录权限应**仅授予服务账户**，不要给 Everyone 或 Users 组。
4. 定期检查服务账户权限：`icacls "C:\ProgramData\MySQL\MySQL Server 8.0\Data"`。

---

## 安装后的常见配置

### 环境变量

将 MySQL bin 目录加入 PATH：

```powershell
# 以管理员身份运行
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\MySQL\MySQL Server 8.0\bin", "Machine")
```

### 首次连接

```powershell
mysql -u root -p
```

### 创建远程访问用户

```sql
CREATE USER '用户名'@'%' IDENTIFIED BY '密码';
GRANT ALL PRIVILEGES ON *.* TO '用户名'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

### 允许远程连接

修改 `my.ini`：

```ini
# 将 bind-address 改为 0.0.0.0（或注释掉以监听所有接口）
bind-address=0.0.0.0
```

重启服务后生效。如果启用了 Windows 防火墙，需放行 3306 端口：

```powershell
New-NetFirewallRule -DisplayName "MySQL 3306" -Direction Inbound -Protocol TCP -LocalPort 3306 -Action Allow
```

### 解决 caching_sha2_password 客户端兼容问题

如果客户端不支持 MySQL 8 的默认认证插件，有两种方案：

**方案一：为特定用户改用旧认证**

```sql
ALTER USER '用户名'@'host' IDENTIFIED WITH mysql_native_password BY '密码';
```

**方案二：全局改为旧认证（不推荐）**

在 `my.ini` 中添加：

```ini
[mysqld]
default_authentication_plugin=mysql_native_password
```

---

## 卸载

```powershell
# 停止并删除服务
net stop MySQL80
sc delete MySQL80

# 通过"设置 → 应用"或 MySQL Installer 卸载
# 手动删除残留
Remove-Item -LiteralPath "C:\Program Files\MySQL" -Recurse -Force
Remove-Item -LiteralPath "C:\ProgramData\MySQL" -Recurse -Force
```

---

## 参考

- [MySQL 8.0 Reference Manual — Installing MySQL on Microsoft Windows](https://dev.mysql.com/doc/refman/8.0/en/windows-installation.html)
- [MySQL 8.0 Reference Manual — Starting MySQL as a Windows Service](https://dev.mysql.com/doc/refman/8.0/en/windows-start-service.html)
