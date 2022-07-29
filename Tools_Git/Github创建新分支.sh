# 查看本地分支
git branch

# 查看远程分支
git branch -r

# 查看所有分支
git branch -a

# 本地创建新的分支
git branch [branch name]

# 切换到新的分支
git checkout [branch name]

# 创建+切换分支
git checkout -b [branch name]

# 将新分支推送到github
git push origin [branch name]

# 删除本地分支
git branch -d [branch name]

# 删除github远程分支
git push origin :[branch name]

# https://blog.csdn.net/top_code/article/details/51931916

为某个版本创建新的分支
git checkout -b [新建分支名] [要被复制的版本哈希]
