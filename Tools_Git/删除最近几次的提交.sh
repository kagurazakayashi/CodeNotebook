# 回滚最近几次的提交

# 1. 回滚到上一次提交
git reset --hard HEAD^
# 每执行一次回滚一次的提交。

# 2. 强制提交本地代码
git push origin master -f


# 删除指定commit提交

# 1. 查看 commit log id ， 4 为查看最近 4 条
git log -4

# 2. 改写从 21a254a2b7 commit id 开始后的所有提交记录。
git rebase -i 21a254a2b7^
# 会打开文本编辑器，然后我们就可以针对我们不需要的某些 log 进行删除了：把原本的 「pick」 单词修改为 「drop」 就表示该 commit log 我们需要删除。

# 3. 强制提交本地代码
git push origin master -f

# https://www.jianshu.com/p/335e5ac0a823