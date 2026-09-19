# IIS 安装 PHP

## 下载 PHP

从 [windows.php.net/download](https://windows.php.net/download) 下载 **Non Thread Safe (NTS)** 版本的 PHP ZIP 包。

> 由于 IIS 使用 FastCGI，必须使用 Non Thread Safe 版本；Thread Safe 版本用于 Apache。

## 方法一：Chocolatey 安装（推荐）

```powershell
# 安装 PHP
choco install php -y

# 安装 IIS 的 CGI 功能（如果未启用）
Enable-WindowsOptionalFeature -Online -FeatureName IIS-CGI -All

# 刷新环境变量，然后重启 IIS
refreshenv; iisreset
```

> 安装完成后按目录 `C:\tools\php*` 找到实际 PHP 路径，继续执行下方 [IIS 配置处理程序映射](#5-iis-配置处理程序映射) 及后续步骤。

## 方法二：手动安装

### 1. 解压 PHP

将 ZIP 解压到目标目录，例如 `C:\PHP`。

### 2. 配置 php.ini

```ini
# 将 php.ini-production 复制为 php.ini
# 常用配置项：
cgi.force_redirect = 0
cgi.fix_pathinfo = 1
fastcgi.impersonate = 1
extension_dir = "ext"

# 根据需要启用扩展（去掉前面的分号）
extension=curl
extension=mbstring
extension=openssl
extension=mysqli
extension=pdo_mysql
```

### 3. IIS 添加 FastCGI 模块

- **控制面板** → **启用或关闭 Windows 功能** → 勾选 **CGI**（在万维网服务 → 应用程序开发功能下）
- 或者在 PowerShell 中：

```powershell
Add-WindowsFeature Web-CGI
```

### 4. 添加系统环境变量

将 PHP 目录（如 `C:\PHP`）添加到系统 **PATH** 环境变量中。

### 5. IIS 配置处理程序映射

打开 **IIS 管理器**，选择服务器级或站点级：

1. 双击 **处理程序映射**
2. 点击右侧 **添加模块映射**
   - 请求路径：`*.php`
   - 模块：`FastCgiModule`
   - 可执行文件：`C:\PHP\php-cgi.exe`
   - 名称：`PHP_via_FastCGI`
3. 点击"是"确认创建 FastCGI 应用程序

### 6. 配置 FastCGI 设置（可选优化）

IIS 管理器 → 服务器级 → **FastCGI 设置**：

| 设置项 | 建议值 | 说明 |
| ------ | ------ | ---- |
| 实例最大请求数 | 10000 | 每个进程处理多少请求后回收 |
| 最大实例数 | 0 | 0 = 自动，根据负载调整 |
| 活动超时 | 300 | 秒，空闲进程超时回收 |
| 请求超时 | 90 | 秒，单个请求最大执行时间 |
| `PHP_FCGI_MAX_REQUESTS` | 10000 | 环境变量，同实例最大请求数 |

### 7. 重启 IIS

```powershell
iisreset
```

### 8. 验证

在站点根目录创建 `info.php`：

```php
<?php phpinfo(); ?>
```

浏览器访问 `http://localhost/info.php`，出现 PHP 信息页即为成功。

## 常用问题

### 403 或 500 错误

检查应用程序池对该目录是否有读取权限，以及 FastCGI 模块是否正确安装。

### 缺失 msvcr 或 vcruntime 运行库

下载并安装 **Visual C++ Redistributable for Visual Studio**（版本与 PHP 对应，一般需要 VC15+ / VS 2022）。

### 启动 mysqli 扩展

1. 打开 `php.ini`，确保 `extension_dir` 指向正确的 ext 目录：

   ```ini
   extension_dir = "ext"
   ```

   也可使用绝对路径，例如 `extension_dir = "C:\PHP\ext"`。

2. 找到并取消注释（去掉前面分号）：

   ```ini
   extension=mysqli
   ```

   如果需要连接 MySQL，通常也建议一并启用：

   ```ini
   extension=pdo_mysql
   ```

3. 重启 IIS 使配置生效：

   ```powershell
   iisreset
   ```

4. 在 `phpinfo()` 页面搜索 `mysqli`，看到独立的 `mysqli` 区块即为启动成功。

### 启动 Bzip2 与 Zip 扩展

在 `php.ini` 中取消以下行注释：

```ini
extension=bz2
extension=zip
```

重启 IIS 后在 `phpinfo()` 页面分别搜索 `bz2` 和 `zip`，看到对应区块即为启动成功。

### 中文乱码

在 `php.ini` 中设置 `default_charset = "UTF-8"`，IIS 相应配置响应头编码。

---

> 原文链接（参考）：https://learn.microsoft.com/zh-cn/iis/application-frameworks/install-and-configure-php-on-iis
