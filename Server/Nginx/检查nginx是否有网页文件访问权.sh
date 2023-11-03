# 检查 nginx 的运行用户
ps -ef| grep nginx
# 用 nginx 的运行用户 www 执行 ls 列出网页文件夹，看看是否 permission deny
sudo -u www ls /www/wwwroot/
# 如果权限不对则给权限
sudo chown www: -R /www/wwwroot/