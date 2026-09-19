# Linux 桌面入口（.desktop）Categories 分类

## 概述

Categories 字段定义在 `.desktop` 文件中，遵循 [FreeDesktop.org Desktop Menu Specification](https://specifications.freedesktop.org/menu-spec/latest/apa.html)。
应用菜单程序根据 Categories 将程序放入对应菜单分组。**多个类别用分号（`;`）分隔，结尾也要有分号。**

---

## 使用语法

```ini
# 单类别
Categories=Development;

# 多类别：IDE 首先属于 Development，其次属于 GTK
Categories=Development;IDE;GTK;

# 网络浏览器同时属于 Network 主类别
Categories=Network;WebBrowser;GTK;
```

---

## 一、主类别（Main Categories）

所有合规桌面环境**必须支持**。一个应用只有包含以下至少一个主类别，才会出现在菜单中。

| 类别 | 中文说明 | 说明 |
|------|----------|------|
| `AudioVideo` | 多媒体 | 音频/视频应用 |
| `Audio` | 音频 | 必须同时包含 `AudioVideo` |
| `Video` | 视频 | 必须同时包含 `AudioVideo` |
| `Development` | 开发 | 开发工具、IDE、调试器等 |
| `Education` | 教育 | 教学、学习软件 |
| `Game` | 游戏 | 各类游戏 |
| `Graphics` | 图形 | 图像处理、绘图 |
| `Network` | 网络 | 浏览器、邮件、聊天等 |
| `Office` | 办公 | 文字处理、表格、演示等 |
| `Science` | 科学 | 科学计算、数据分析 |
| `Settings` | 设置 | 系统设置、控制面板 |
| `System` | 系统 | 系统工具、监控 |
| `Utility` | 附件 | 小工具、辅助程序 |

---

## 二、附加类别（Additional Categories）

附加类别提供**更精细的分类**，必须与主类别配合使用。下表列出常用附加类别及其关联的主类别。

### 开发相关

| 类别 | 关联主类别 | 中文说明 |
|------|-----------|----------|
| `IDE` | Development | 集成开发环境 |
| `Debugger` | Development | 调试器 |
| `Profiling` | Development | 性能分析 |
| `RevisionControl` | Development | 版本控制（Git 客户端等） |
| `WebDevelopment` | Development | Web 开发 |
| `Building` | Development | 构建工具（make、cmake 等） |
| `GUIDesigner` | Development | GUI 界面设计器 |
| `Translation` | Development | 翻译工具 |
| `Documentation` | Development | 文档工具 |

### 办公相关

| 类别 | 关联主类别 | 中文说明 |
|------|-----------|----------|
| `WordProcessor` | Office | 文字处理 |
| `Spreadsheet` | Office | 电子表格 |
| `Presentation` | Office | 演示文稿 |
| `Calendar` | Office | 日历 |
| `ContactManagement` | Office | 联系人管理 |
| `Database` | Office;Development;AudioVideo | 数据库 |
| `Dictionary` | Office;TextTools | 字典 |
| `Chart` | Office | 图表 |
| `FlowChart` | Office | 流程图 |
| `Finance` | Office | 财务 |
| `ProjectManagement` | Office;Development | 项目管理 |
| `Publishing` | Graphics;Office | 桌面出版 |
| `Email` | Office;Network | 电子邮件客户端 |
| `OCR` | Graphics;Office | 光学字符识别 |

### 图形相关

| 类别 | 关联主类别 | 中文说明 |
|------|-----------|----------|
| `Photography` | Graphics;AudioVideo | 摄影处理 |
| `RasterGraphics` | Graphics | 位图编辑（GIMP 等） |
| `VectorGraphics` | Graphics | 矢量图编辑（Inkscape 等） |
| `2DGraphics` | Graphics | 二维图形 |
| `3DGraphics` | Graphics | 三维图形（Blender 等） |
| `Scanning` | Graphics | 扫描工具 |
| `ImageProcessing` | Education;Science | 图像处理 |
| `Viewer` | Graphics | 图像查看器 |

### 网络相关

| 类别 | 关联主类别 | 中文说明 |
|------|-----------|----------|
| `WebBrowser` | Network | 网页浏览器 |
| `Email` | Office;Network | 电子邮件 |
| `Chat` | Network | 聊天 |
| `IRCClient` | Network | IRC 客户端 |
| `InstantMessaging` | Network | 即时通讯 |
| `FileTransfer` | Network | 文件传输 |
| `FTP` | Network | FTP 客户端 |
| `P2P` | Network | P2P 文件共享 |
| `News` | Network | 新闻阅读 |
| `RemoteAccess` | Network | 远程访问（SSH、RDP 等） |
| `Telephony` | Network | 网络电话 |
| `HamRadio` | Network | 业余无线电 |

### 系统相关

| 类别 | 关联主类别 | 中文说明 |
|------|-----------|----------|
| `FileManager` | System;Utility | 文件管理器 |
| `TerminalEmulator` | System;Utility | 终端模拟器 |
| `Filesystem` | System | 文件系统工具（分区等） |
| `Monitor` | System;Network | 系统监控 |
| `Security` | System;Settings | 安全工具 |
| `PackageManager` | Settings;System | 软件包管理器 |
| `AntiVirus` | System | 防病毒 |

### 设置相关

| 类别 | 关联主类别 | 中文说明 |
|------|-----------|----------|
| `HardwareSettings` | Settings | 硬件设置 |
| `DesktopSettings` | Settings | 桌面设置 |
| `Printing` | Settings;HardwareSettings | 打印设置 |
| `ScreenSaver` | Settings | 屏幕保护设置 |
| `Accessibility` | Settings;Utility | 辅助功能设置 |

### 工具相关

| 类别 | 关联主类别 | 中文说明 |
|------|-----------|----------|
| `Calculator` | Utility | 计算器 |
| `Clock` | Utility | 时钟 |
| `TextEditor` | Utility | 文本编辑器 |
| `TextTools` | Utility | 文本处理工具 |
| `Archiving` | Utility | 归档管理 |
| `Compression` | Utility | 压缩工具 |
| `FileTools` | Utility;System | 文件工具 |
| `TelephonyTools` | Utility | 电话工具 |

### 音视频相关

| 类别 | 关联主类别 | 中文说明 |
|------|-----------|----------|
| `Player` | AudioVideo | 播放器 |
| `Recorder` | AudioVideo | 录音/录像 |
| `DiscBurning` | AudioVideo | 光盘刻录 |
| `AudioVideoEditing` | AudioVideo | 音视频编辑 |
| `Midi` | AudioVideo;Audio | MIDI 工具 |
| `Mixer` | AudioVideo;Audio | 混音器 |
| `Sequencer` | AudioVideo;Audio | 音序器 |
| `Tuner` | AudioVideo;Audio | 调谐器/收音机 |
| `TV` | AudioVideo;Video | 电视 |
| `Music` | AudioVideo;Education | 音乐学习 |

### 教育/科学相关

| 类别 | 关联主类别 | 中文说明 |
|------|-----------|----------|
| `Art` | Education;Science | 艺术 |
| `ArtificialIntelligence` | Education;Science | 人工智能 |
| `Astronomy` | Education;Science | 天文学 |
| `Biology` | Education;Science | 生物学 |
| `Chemistry` | Education;Science | 化学 |
| `ComputerScience` | Education;Science | 计算机科学 |
| `Construction` | Education;Science | 建筑 |
| `DataVisualization` | Education;Science | 数据可视化 |
| `Economy` | Education;Science | 经济 |
| `Electricity` | Education;Science | 电气 |
| `Electronics` | Education;Science | 电子 |
| `Engineering` | Education;Science | 工程 |
| `Geography` | Education;Science | 地理 |
| `Geology` | Education;Science | 地质 |
| `Geoscience` | Education;Science | 地球科学 |
| `History` | Education;Science | 历史 |
| `Humanities` | Education;Science | 人文学科 |
| `Languages` | Education;Science | 语言 |
| `Literature` | Education;Science | 文学 |
| `Maps` | Education;Science | 地图 |
| `Math` | Education;Science | 数学 |
| `MedicalSoftware` | Education;Science | 医疗软件 |
| `NumericalAnalysis` | Education;Science | 数值分析 |
| `ParallelComputing` | Education;Science | 并行计算 |
| `Physics` | Education;Science | 物理 |
| `Robotics` | Education;Science | 机器人 |
| `Spirituality` | Education;Science | 灵修/宗教 |
| `Sports` | Education;Science | 体育 |

### 游戏相关

| 类别 | 关联主类别 | 中文说明 |
|------|-----------|----------|
| `ActionGame` | Game | 动作游戏 |
| `AdventureGame` | Game | 冒险游戏 |
| `ArcadeGame` | Game | 街机游戏 |
| `BoardGame` | Game | 棋盘游戏 |
| `BlocksGame` | Game | 益智方块（俄罗斯方块类） |
| `CardGame` | Game | 纸牌游戏 |
| `KidsGame` | Game | 儿童游戏 |
| `LogicGame` | Game | 逻辑游戏 |
| `RolePlaying` | Game | 角色扮演 |
| `Shooter` | Game | 射击游戏 |
| `Simulation` | Game | 模拟游戏 |
| `SportsGame` | Game | 体育游戏 |
| `StrategyGame` | Game | 策略游戏 |
| `Amusement` | Game | 娱乐 |
| `Emulator` | System;Game | 模拟器 |

### 桌面环境标记（用于限定显示环境）

| 类别 | 说明 |
|------|------|
| `GNOME` | 仅在 GNOME 桌面环境下显示 |
| `GTK` | 仅在使用 GTK 的环境下显示 |
| `KDE` | 仅在 KDE 桌面环境下显示 |
| `Qt` | 仅在使用 Qt 的环境下显示 |
| `Motif` | 仅在使用 Motif 的环境下显示 |
| `Java` | 在 Java 环境下显示 |
| `ConsoleOnly` | 仅控制台应用 |
| `Core` | 核心系统组件 |

---

## 三、应用方法

### 3.1 查看系统注册的类别

```bash
# 查看系统菜单中注册的所有类别（GNOME 环境）
grep -rhoP '^Categories=.*$' /usr/share/applications/ | sort -u

# 统计各类别出现次数
grep -rhoP '(?<=Categories=)[^;]+' /usr/share/applications/ | sort | uniq -c | sort -rn
```

### 3.2 创建系统级 .desktop 文件

文件位置：`/usr/share/applications/程序名.desktop`

```ini
[Desktop Entry]
Type=Application
Name=我的程序
Name[zh_CN]=我的程序
Comment=这是一个示例程序
Comment[zh_CN]=这是一个示例程序
Exec=/usr/local/bin/myapp
Icon=/usr/local/share/icons/myapp.png
Terminal=false
Categories=Development;IDE;GTK;
Keywords=编程;代码;编辑器;
```

### 3.3 创建用户级 .desktop 文件

文件位置：`~/.local/share/applications/程序名.desktop`

```ini
[Desktop Entry]
Type=Application
Name=My Script
Exec=/home/user/bin/my_script.sh
Icon=utilities-terminal
Terminal=true
Categories=Utility;TerminalEmulator;
```

### 3.4 常用字段说明

| 字段 | 必填 | 说明 |
|------|------|------|
| `Type` | 是 | `Application`（普通应用）、`Link`（链接）、`Directory`（目录） |
| `Name` | 是 | 显示名称 |
| `Exec` | 是 | 执行的命令及参数 |
| `Icon` | 否 | 图标路径或图标名称 |
| `Terminal` | 否 | `true` = 在终端中运行；`false` = 不打开终端 |
| `Comment` | 否 | 工具提示说明 |
| `Categories` | 否 | 菜单分类 |
| `Keywords` | 否 | 搜索关键词（分号分隔） |
| `MimeType` | 否 | 关联的文件类型列表 |
| `NoDisplay` | 否 | `true` = 不在菜单中显示 |
| `OnlyShowIn` | 否 | 仅在指定桌面环境显示（如 `GNOME;KDE;`） |
| `NotShowIn` | 否 | 在指定桌面环境不显示 |
| `StartupNotify` | 否 | `true` = 启动时显示等待光标 |
| `StartupWMClass` | 否 | 窗口管理器类名（用于正确分组窗口） |
| `Hidden` | 否 | `true` = 隐藏此入口 |
| `TryExec` | 否 | 若此程序路径不存在，入口不可见 |

### 3.5 刷新菜单缓存

```bash
# 更新 desktop 数据库（安装/修改 .desktop 后执行）
sudo update-desktop-database

# 或手动重建 GNOME Shell 应用缓存（无需 root）
update-desktop-database ~/.local/share/applications/
```

### 3.6 验证 .desktop 文件格式

```bash
# 使用 desktop-file-validate 检查（需安装 desktop-file-utils）
desktop-file-validate /usr/share/applications/程序名.desktop

# 安装验证工具
# Debian/Ubuntu:
sudo apt install desktop-file-utils

# CentOS/RHEL/Fedora:
sudo dnf install desktop-file-utils
```

---

## 四、完整示例

```ini
# ~/.local/share/applications/my-dev-tool.desktop
# 一个自定义开发工具的桌面入口示例

[Desktop Entry]
Type=Application
Name=MyDevTool
Name[zh_CN]=我的开发工具
GenericName=Development Tool
GenericName[zh_CN]=开发工具
Comment=A powerful development utility
Comment[zh_CN]=一个强大的开发工具
Exec=/home/yashi/bin/mydevtool %F
Icon=/home/yashi/.local/share/icons/mydevtool.png
Terminal=false
Categories=Development;IDE;GTK;
Keywords=编程;开发;代码;调试;build;
MimeType=text/plain;text/x-python;text/x-csrc;
StartupNotify=true
StartupWMClass=MyDevTool
```

说明：
- `%F`：表示可传入多个文件路径作为参数
- `%f`：表示传入单个文件路径
- `%U`：多个 URL
- `%u`：单个 URL
- `%i`：传入 `--icon` 及 Icon 的值

---

## 五、保留类别（不在 .desktop 中使用）

以下类别保留给系统内部使用，不应写入 `.desktop` 文件：

| 保留类别 | 用途 |
|----------|------|
| `Screensaver` | 屏幕保护程序（由系统管理） |
| `TrayIcon` | 系统托盘图标 |
| `Applet` | 面板小程序/插件 |
| `Shell` | Shell 扩展 |

---

> 参考文档：[FreeDesktop.org Desktop Menu Specification](https://specifications.freedesktop.org/menu-spec/latest/apa.html)
