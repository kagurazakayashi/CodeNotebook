REM 共享文件夹 share-b ，share读写，yashi完全控制，最多3个用户连接：

net share "share-b"=B:\share-b /GRANT:share,CHANGE /GRANT:yashi,FULL /USERS:3

REM 此命令的语法是:
REM NET SHARE
REM sharename
REM           sharename=drive:path [/GRANT:user,[READ | CHANGE | FULL]]
REM                                [/USERS:number | /UNLIMITED]
REM                                [/REMARK:"text"]
REM                                [/CACHE:Manual | Documents| Programs | BranchCache | None]
REM           sharename [/USERS:number | /UNLIMITED]
REM                     [/REMARK:"text"]
REM                     [/CACHE:Manual | Documents | Programs | BranchCache | None]
REM           {sharename | devicename | drive:path} /DELETE
REM           sharename \\computername /DELETE