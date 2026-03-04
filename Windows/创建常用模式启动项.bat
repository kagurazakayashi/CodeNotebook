bcdedit /set {bootmgr} displaybootmenu yes
REM 创建常用模式启动项

bcdedit /copy {current} /d "Windows 11 Safe Mode"
bcdedit /set {xxxx} SafeBoot Minimal
bcdedit /copy {current} /d "Windows 11 Safe Mode Networking"
bcdedit /set {xxxx} SafeBoot Network
bcdedit /copy {current} /d "Windows 11 Safe Mode CMD"
bcdedit /set {xxxx} SafeBoot Minimal
bcdedit /set {xxxx} SafeBoot AlternateShell yes
bcdedit /copy {current} /d "Windows 11 ntbtlog.txt"
bcdedit /set {xxxx} bootlog Yes
禁用 Hyper-V:
bcdedit /copy {current} /d "Windows 11 no Hyper-V"
bcdedit /set {xxxx} HypervisorLaunchType off

REM 禁用多次重启后运行自动修复功能
bcdedit /copy {current} /d "Windows 11 no recovery"
bcdedit /set {xxxx} recoveryenabled no

REM 串口调试（会一直占用这个端口）
bcdedit /copy {current} /d "Windows 11 COM1 Debug"
bcdedit /set {xxxx} debug yes
REM 启用串口调试
bcdedit /set {xxxx} debugtype serial
REM 使用 COM ID
bcdedit /set {xxxx} debugport 0
REM 常用速率，需与串口终端匹配（默认值 19200 bps）
bcdedit /set {xxxx} baudrate 115200
ECHO 波特率 (Baud Rate)	115200	与 bcdedit 中设置一致
ECHO 数据位 (Data Bits)	8	Windows 串口调试默认
ECHO 校验位 (Parity)	None	无奇偶校验
ECHO 停止位 (Stop Bits)	1	单停止位
ECHO 流控 (Flow Control)	None	不启用 RTS/CTS 或 XON/XOFF


REM 开启 EMS（Bootmgr启动菜单的命令行，如果启用了 EMS，Bootmgr 会优先通过串口输出引导界面内容！）
bcdedit /ems {xxxx} on
REM 默认波特率是 9600 bps，9600 与 BIOS/UEFI 中很多传统串口控制台设置保持一致
bcdedit /emssettings EMSPORT:1 EMSBAUDRATE:115200
REM 关闭 EMS
bcdedit /ems {xxxx} off

REM 删除配置项
bcdedit /deletevalue {current} debug
bcdedit /deletevalue {current} debugtype
bcdedit /deletevalue {current} debugport
bcdedit /deletevalue {current} baudrate

REM 指定其他菜单：找出目标 BCD 中的启动项 Identifier：
bcdedit /store C:\boot\bcd /enum

REM 查看配置列表
bcdedit /enum
bcdedit /enum all

REM 旧版 Windows:
notepad C:\boot.ini
REM 复制一行启动项，保存文件
msconfig
REM 配置上述 /SafeBoot
