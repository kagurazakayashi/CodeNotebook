# (mysql) my.ini
```
[mysqld]
ssl-ca = "sql-cert/ca.cer"
ssl-cert = "sql-cert/sql.cer"
ssl-key = "sql-cert/sql.key"
```
# (phpmyadmin) config.inc.php
```
$i++;
$cfg['Servers'][$i]['auth_type'] = 'cookie';
$cfg['Servers'][$i]['host'] = '192.168.2.100';
$cfg['Servers'][$i]['compress'] = false;
$cfg['Servers'][$i]['AllowNoPassword'] = false;
$cfg['Servers'][$i]['ssl'] = true;
$cfg['Servers'][$i]['ssl_key'] = "sql-cert/sql.key";
$cfg['Servers'][$i]['ssl_cert'] = "sql-cert/sql.cer";
$cfg['Servers'][$i]['ssl_ca'] = "sql-cert/ca.cer";
$cfg['Servers'][$i]['ssl_verify'] = false;
```