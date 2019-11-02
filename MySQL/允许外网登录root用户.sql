-- # mysql -u root -p
use mysql;
update user set host = '%' where user = 'root';
select host, user from user;