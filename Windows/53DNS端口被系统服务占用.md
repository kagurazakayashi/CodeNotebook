# 53DNS端口被系统服务占用

1. 查看指定端口的占用情况（若查询其他端口，只需要修改端口数字就好。）
    - `netstat -ano|findstr 53` 得到 PID

2. 使用对应的PID，反查到什么程序在占用端口。
    - `tasklist | findstr [PID]`

3. 关闭指定进程
    1. 如果是 scvhost.exe
        1. 停止 `主机网络服务`
        2. 停止并禁用 `Internet Connection Sharing (ICS)`, `named` 服务
    2. 其他程序: `taskkill -PID [PID] -F` 强制关闭指定进程

## Internet Connection Sharing (ICS) 无法停止

```bat
net stop hns
net stop SharedAccess
```

`net start hns` 的话 SharedAccess 也会跟着自己起来。
