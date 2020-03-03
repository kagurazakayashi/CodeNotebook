1. 分别在主从服务器上安装MySQL,最好版本相同。
2. 修改Master上MySQL配置文件my.cnf
```
[mysqld]
log-bin=mysql-bin   // [必须]启用二进制日志
server-id=1         // [必须]服务器唯一ID
binlog-ignore-db=information_schema // 不参与同步
binlog-ignore-db=performance_schema // 不参与同步
binlog-ignore-db=mysql // 不参与同步
binlog-ignore-db=phpmyadmin // 不参与同步
binlog-do-db=workdata // 参与同步
```
3. 修改Slave上MySQL配置文件my.cnf
```
[mysqld]
log-bin=mysql-bin   // [非必须]Slave可以不启用二进制日志，配置二进制日志可以便于Master和Slave交换角色
server-id=2         // [必须]服务器唯一ID
binlog-ignore-db=information_schema // 不参与同步
binlog-ignore-db=performance_schema // 不参与同步
binlog-ignore-db=mysql // 不参与同步
binlog-ignore-db=phpmyadmin // 不参与同步
binlog-do-db=workdata // 参与同步
```
4. 重启Master和Slave上的MySQL
5. 在Master上使用root用户登录建立同步账户并授权Slave
mysql> `GRANT REPLICATION SLAVE ON *.* to 'sync'@'%' identified by 'EQPxc17cDvarEmBSW3NqfZf8RPtZ0FRU';`
mysql> `grant all privileges on *.* to 'sync'@'%' with grant option;`
mysql> `FLUSH PRIVILEGES;`
6. 使用root账户登录Master查看Master状态
mysql> `show master status;`
```
+------------------+----------+--------------+------------------+-------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
+------------------+----------+--------------+------------------+-------------------+
| mysql-bin.000002 |     6584 | thisonedb    | mysql            |                   |
+------------------+----------+--------------+------------------+-------------------+
```
7. 配置Slave跟踪Master日志的位置
mysql> `change master to master_host='192.168.50.2',master_user='sync',master_password='EQPxc17cDvarEmBSW3NqfZf8RPtZ0FRU',master_log_file='mysql-bin.000002',master_log_pos=6584;`
mysql> `start slave;`
8. 使用root账户登录MySQL核对Slave状态
mysql> `show slave status;`
```
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event 
                  Master_Host: 10.16.13.128
                  Master_User: username
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000002
          Read_Master_Log_Pos: 6584
               Relay_Log_File: bx-13-129-relay-bin.000003
                Relay_Log_Pos: 6797
        Relay_Master_Log_File: mysql-bin.000002
             Slave_IO_Running: Yes 
            Slave_SQL_Running: Yes
```
需要特别核对Slave_IO_State、Slave_IO_Running、Slave_SQL_Running 值，以上值为正确配置状态。
9. 检查主从备份是否配置成功，在Master上创建Table或插入数据，查看Slave数据是否与Master同步
10. 用crontab设置定期任务执行脚本检查Slave状态
```
# !/bin/bash
array=($(mysql -uroot -p -e "show slave status\G" | grep "Running" | awk '{print $2}'))
if [ "${array[0]}" == "Yes" ] || [ "${array[1]}" == "Yes" ]
    then
        echo "Slave is OK"
    else
        echo "Slave is error"
fi
```

<!-- https://www.jianshu.com/p/1eed312e83bf -->