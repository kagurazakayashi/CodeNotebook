要**移动 Windows 下的 Thunderbird 用户数据**（包括邮件、账户设置、插件等），可以通过以下步骤操作：

# Thunderbird 用户数据路径

默认位置在：

```
%APPDATA%\Thunderbird
```

其中最关键的是这个目录下的：

```
Profiles\xxxxxxxx.default-release\
```

## 步骤一：关闭 Thunderbird

确保 Thunderbird 已完全退出（包括后台进程）。

## 步骤二：复制旧数据目录

1. 打开资源管理器，输入地址栏：

   ```
   %APPDATA%\Thunderbird
   ```
2. 复制整个 `Thunderbird` 文件夹到你希望移动的位置，例如：

   ```
   D:\yashi\Thunderbird\
   ```

## 步骤三：使用 `profiles.ini` 重定向配置路径（推荐）

在新的机器或新系统中，执行以下操作：

1. 打开：

   ```
   %APPDATA%\Thunderbird\
   ```
2. 编辑或替换 `profiles.ini` 内容如下（举例）：

   ```ini
   [General]
   StartWithLastProfile=1

   [Profile0]
   Name=default
   IsRelative=0
   Path=D:\yashi\Thunderbird\Profiles\xxxxxxxx.default-release
   Default=1
   ```

   * `IsRelative=0` 表示使用绝对路径。
   * 确保 `Path` 指向你的新位置的配置目录。

## 可选步骤：使用 `-profile` 启动参数（临时或测试用）

```bash
thunderbird.exe -profile "D:\yashi\Thunderbird\Profiles\xxxxxxxx.default-release"
```

你可以创建一个快捷方式，在“目标”栏加上上述参数。

## 清理（可选）

确认新路径启动无误后，可以删除旧的：

```
%APPDATA%\Thunderbird
```
