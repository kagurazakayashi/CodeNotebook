# git指定日期 git 提交时指定提交时间

# Windows
set GIT_COMMITTER_DATE="2023-03-03T20:00:00"
set GIT_AUTHOR_DATE="%GIT_COMMITTER_DATE%"
git commit --date %GIT_COMMITTER_DATE% -m ""

# macOS/Linux
export GIT_COMMITTER_DATE="2023-03-03T20:00:00"
export GIT_AUTHOR_DATE="$GIT_COMMITTER_DATE"
git commit --date "$GIT_COMMITTER_DATE" -m ""

# 日期可以有多种写法，例如以下日期均可：
# Sun Mar 13 2022 01:27:39 GMT+0800 (新加坡标准时间)
# Mon Sep 2 16:21:24 2021 +0800
# 2017-10-08T09:51:07
