REM 共享文件夹 share-b ，share读写，yashiREM完全控制，最多3个用户连接：

B:
net share share-b /delete
MKDIR B:\share-b
net share "share-b"=B:\share-b /GRANT:share,CHANGE /GRANT:yashi,FULL /USERS:3


net share sharename=folderpath /grant:username,permissions
REM sharename: 要创建的共享名称
REM username : 可以访问共享该文件夹的用户ID
REM permission: 访问共享文件夹的权限：Read, Change or Full

REM 删除共享
net share sharename /delete
REM 查看共享
net share

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