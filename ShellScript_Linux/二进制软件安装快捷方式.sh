# 二进制软件安装快捷方式

# ~/apps/myapp/
# ├── myapp          # 可执行文件
# ├── myapp.desktop  # 启动器文件
# └── myapp.png      # 图标

# myapp.desktop:
# [Desktop Entry]
# Exec=/usr/bin/myapp
# Icon=myapp

# 安装软件

# 软链接到用户级
chmod +x ~/apps/myapp/myapp
sudo ln -s /home/你的用户名/apps/myapp/myapp /usr/bin/myapp
# 添加图标软链接(也可直接复制过去)
sudo ln -s /home/你的用户名/apps/myapp/myapp.png /usr/share/pixmaps/myapp.png
# 某些桌面环境可能需要刷新应用菜单：
update-desktop-database ~/.local/share/applications/

# 创建快捷方式

# 把 .desktop 文件复制到本地的程序菜单目录：
cp ~/apps/myapp/myapp.desktop ~/.local/share/applications/
# 给它执行权限（某些桌面环境要求）：
chmod +x ~/.local/share/applications/myapp.desktop

# 复制一份 .desktop 到桌面：
cp ~/apps/myapp/myapp.desktop ~/Desktop/
# 给它加执行权限：
chmod +x ~/Desktop/myapp.desktop
