TITLE 以指定时刻的随机分秒提交 随机时间提交
@ECHO OFF
REM git_time 2024-01-01 "sync"  =  git commit --date 2024-11-24T20:??:?? -m "sync"
SET /A MINUTE=%random% %% 60
if %MINUTE% lss 10 set MINUTE=0%MINUTE%
SET /A SECOND=%random% %% 60
if %SECOND% lss 10 set SECOND=0%SECOND%
SET GIT_COMMITTER_DATE=%1T20:%MINUTE%:%SECOND%
SET GIT_AUTHOR_DATE=%GIT_COMMITTER_DATE%
SET MINUTE=
SET SECOND=
ECHO ON
git commit --date %GIT_COMMITTER_DATE% -m %2
