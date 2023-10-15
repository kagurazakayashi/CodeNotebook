# tmux 的 session 常用操作

# 新建序号名 session
tmux
# 新建带名字 session
tmux new -s session-name
# 离开 session，任务继续在后台执行 ctrl+b d
tmux detach
# 查看 session 列表 ctrl+b s
tmux ls
# 进入 session
tmux attach -t session-name
tmux a -t session-name
# 关闭 session  ctrl + d
tmux kill-session -t session-name
# 切换 session
tmux switch -t session-name
# 重命名 session
tmux rename-session -t old-session-name new-session-name


# tmux 的窗格常用操作

# 该命令会把当前工作区域分成上下两个小窗格 ctrl+b "
tmux split-window
# 该命令会把当前工作区域分成左右两个窗格 ctrl+b %
tmux split-window -h

# 不同窗格间移动光标  ctrl+b ↑↓←→
# 把当前光标移动到上方的窗格
tmux select-pane -U
# 把当前的光标移动的下方的窗格
tmux select-pane -D
# 把当前的光标移动到左边的窗格
tmux select-pane -L
# 把当前的光标移动到右边的窗格
tmux select-pane -R
# ctrl+b ; 光标切换到上一个窗格
# ctrl+b o 光标切换到下一个窗格

# 当前窗格向上移动
tmux swap-pane -U
# 当前窗格向下移动
tmux swap-pane -D

# 最大化当前的窗格  ctrl+b z
# 关闭当前的窗格    ctrl+b x
# 窗格显示时间      ctrl+b t  (回车键将会复原)


# tmux 的窗口常用操作

# 创建一个窗口  ctrl+b c
tmux new-window -n window-name

# 切换窗口
tmux select-window -t window-name

# 显示窗口列表      ctrl+b w  通过 j ,k 上下进行选择窗口，然后回车进入指定的窗口。
# 切换到下一个窗口  ctrl+b n
# 切换到上一个窗口  ctrl+b p
# 切换窗口          ctrl+b 0-9

# 重命名窗口  ctrl+b ,
tmux rename-window new-window-name

# 关闭窗口  ctrl+b &
tmux kill-window -t window-name


# tmux 的配置文件 .tmux.conf
# 在 tmux 中我们可以通过 ctrl + b ? 来查找 tmux 的帮助文档，可以查询一些功能键的快捷键信息 ，在帮助文档中按下键盘上的 ESC 或者 q 键就可以退出帮助文档。
vim ~/.tmux.conf
# #below reset tmux prefix command key
# set -g prefix C-x
# unbind C-b
# bind C-x send-prefix
# #set swap pane key
# bind-key k select-pane -U
# bind-key j select-pane -D
# bind-key h select-pane -L
# bind-key l select-pane -R
# 该配置文件把 ctrl + b 改成了 ctrl + x , 还有多个窗格之间切换光标可以通过 ctrl + x k 切换到上一个窗格， ctrl + x j 切换到下一个窗格， ctrl +x h 切换到左边的窗格，ctrl + x l 切换到右边的窗格。

# https://zhuanlan.zhihu.com/p/102546608

# 推荐配置文件  https://github.com/gpakosz/.tmux
cd ~
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .
# 编辑配置文件  ctrl+b e
# 鼠标操作      ctrl+b m

# 显示 CPU内存 用量  https://github.com/thewtex/tmux-mem-cpu-load
sudo apt install cmake -y
git clone https://github.com/thewtex/tmux-mem-cpu-load.git
cd tmux-mem-cpu-load
cmake .
make
sudo make install
# ctrl+b e

# +  "#(tmux-mem-cpu-load --colors --interval 2)"

# tmux_conf_theme_status_right="#{prefix}#{mouse}#{pairing}#{synchronized}#{?battery_status,#{battery_status},}#{?battery_bar, #{battery_bar},}#{?battery_percentage, #{battery_percentage},} , %b%d %R | #{username}#{root} | #{hostname}#{pairing} #(tmux-mem-cpu-load --colors --interval 2 --averages-count 0)"
