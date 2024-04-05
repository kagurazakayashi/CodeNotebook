REM Windows 用户

REM 显示登录用户列表
net user

REM 显示特定用户的详细信息
net user 用户名

REM 创建用户账户
net user 用户名 密码 /add

REM 删除用户账户
net user 用户名 /delete

REM 启用用户账户
net user <用户名> /active:yes

REM 禁用用户账户
net user <用户名> /active:no

REM 修改用户密码
net user 用户名 新密码

REM 将用户添加到用户组
net localgroup 用户组名 用户名 /add

REM 从用户组中删除用户
net localgroup 用户组名 用户名 /delete

REM 显示用户账户的授权信息
net user 用户名 /domain

REM 强制用户更改密码
net user 用户名 新密码 /passwordreq:yes
