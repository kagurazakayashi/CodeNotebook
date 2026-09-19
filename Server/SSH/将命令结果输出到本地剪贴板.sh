# 将命令结果输出到本地剪贴板

# 执行一句话命令
ssh user@debian "cat /etc/os-release" | clip


# 在命令行中执行（利用X11转发）

# 1. Windows 上运行 X Server（如 VcXsrv）

# 2. SSH 连接时使用 -X 或 -Y 参数开启 X11 转发：
ssh -X user@debian

# 3. 安装并使用 xclip 或 xsel：
apt install xclip -y

# 将 "Hello from Debian" 复制到本地剪贴板：
echo "Hello from Debian" | xclip -selection clipboard

# 示例：
cat ~/.ssh/id_ed25519 | xclip -selection clipboard
