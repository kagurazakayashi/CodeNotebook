-- 把sex为'1'的数据的headpicture改为'1.png'，sex为'0'的数据的headpicture改为'0.png'
update t_user set headpicture ='0.png' where sex = '0';
-- 全改
UPDATE t_user SET headpicture = null;