# 删除本地所有未提交的更改
git checkout . && git clean -xdf

# 一般 git clean都是配合git reset 使用的

# 如果你有的修改已经加入了暂存区
git reset --hard
git clean -xdf

# git回滚到某一个版本
git reset --hard a136c6923d882ffc9065439f33412936902a1f5d

# 强制提交
git push -f origin master

# 未push但commit回退
git reset --soft HEAD^  # 会保留代码
git reset --hard HEAD^  # 不会保留未提交的代码，回退到上个版本

# https://blog.csdn.net/lxiao_3028/article/details/123826052



# git删除未跟踪文件
# 删除 untracked files
git clean -f
# 连 untracked 的目录也一起删掉
git clean -fd
# 连 gitignore 的untrack 文件/目录也一起删掉 （慎用，一般这个是用来删掉编译出来的 .o之类的文件用的）
git clean -xfd
# 在用上述 git clean 前，墙裂建议加上 -n 参数来先看看会删掉哪些文件，防止重要文件被误删
git clean -nxfd
git clean -nf
git clean -nfd


# git删除所有变更

# 本地所有修改的。没有的提交的，都返回到原来的状态
git checkout .
# 把所有没有提交的修改暂存到stash里面。可用git stash pop回复。
git stash
# 返回到某个节点，不保留修改。
git reset --hard <HASH>
# 返回到某个节点。保留修改
git reset --soft <HASH>
# 返回到某个节点
git clean -df
# git clean 参数
#     -n 显示 将要 删除的 文件 和  目录
#     -f 删除 文件
#     -df 删除 文件 和 目录

# https://cloud.tencent.com/developer/article/1679921


# 可以使用git checkout命令来撤销修改,如：
git checkout -- *
git checkout -- *.txt
git checkout -- rainbow.txt start.txt

# 已将变更加入到暂存区，即已经执行了git add命令，可以使用git reset命令来撤销修改,如：
git reset HEAD *
git reset HEAD *.txt
git reset HEAD rainbow.txt start.txt
# 要注意的是，执行以上命令后，本地的修改并不会消失，而只是从暂存区回到了工作区，即第一种情况下所示的状态。继续用第一种情况下的操作，就可以放弃本地的修改。

# 已经将代码提交到本地仓库，即已经执行git commit命令，此时工作区已经clean,若想撤销之前的修改，需要执行版本回退操作：
#回退到上一个版本
git reset --hard HEAD^
#回退到上上次版本
git reset --hard HEAD^^
git reset --hard HEAD^^^
#回退到指定commitid的版本
git reset --hard commit_id

# https://www.jianshu.com/p/565306500575


# Error：The following untracked working tree files would be overwritten by checkout
git clean -d -fx
# git clean 参数
# -n 显示将要删除的文件和目录；
# -x -----删除忽略文件已经对git来说不识别的文件
# -d -----删除未被添加到git的路径中的文件
# -f -----强制运行
# git clean -n
# git clean -df
# git clean -f

# Error: pathspec '.' did not match any file(s) known to git
git branch -a
git checkout origin/master

# https://blog.csdn.net/Dream_Weave/article/details/105987172
