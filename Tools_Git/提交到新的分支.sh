# 从branchA分支拉了一份代码，做了一些修改，但是不想提交到branchA分支，想新建一个分支branchB保存代码。

# 1. 添加本地需要提交代码
git add .

# 2. 提交本地代码
git commit -m "add my code to new branchB"

# 3. push 到git仓库 
git push origin branchA:branchB
# 仓库中原本没有branchB，提交后会生成新分支branchB，并将本地基于branchA修改的代码提交到branchB中

# 4. 切换新分支
git checkout -b branchB origin/branchB

# https://blog.csdn.net/a19891024/article/details/54138029


# 步骤1：在当前的develop分支上的修改暂存起来
git stash
# 步骤2：暂存修改后，在本地新建分支（develop_backup为新分支的名字）
git checkout -b develop_backup
# 步骤3：将暂存的修改放到新建分支中
git stash pop
# 步骤4：使用命令进行常规的add、commit步骤
git add.
git commit -a "修改内容"
# 步骤5：将提交的内容push到远程服务器(在远程也同步新建分支develop_backup)
git push origin develop:develop_backup

# https://codeantenna.com/a/mRUx21Y1aI
