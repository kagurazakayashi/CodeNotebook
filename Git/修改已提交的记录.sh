# Windows（中文提交者名会乱码）
# https://github.com/PotatoLabs/git-redate
copy git-redate "C:\Program Files\Git\mingw64\libexec\git-core\"

"
# macOS
brew tap PotatoLabs/homebrew-git-redate
brew install git-redate

# 用法
git redate --commits [[number of commits to view]]
# --commits（又名-c）参数是可选的，并且如果没有设置默认为5。

## 一次编辑所有提交
git redate --all

# 你只需要运行git redate并且你将能够编辑最近5次提交的vim中的所有日期（还有一个-c选项，你想要返回多少次提交，它只是默认为5）。