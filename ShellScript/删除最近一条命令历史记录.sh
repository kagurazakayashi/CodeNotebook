# 删除最近一条命令历史记录
history -d $(history 1 | awk '{print $1}')
# history 1 获取最近的一条历史记录。
# awk '{print $1}' 提取该记录的编号。
# history -d <记录编号> 删除该编号的历史记录。

# 使用以下命令来重新加载历史记录文件：
history -n

# 历史记录文件位置
# zsh
vim ~/.zsh_history
# bash
vim ~/.bash_history
# 在 vim 中，移动到文件的末端可以使用以下命令：
# 按下 G：这会将光标直接移动到文件的最后一行。
