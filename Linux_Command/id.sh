# 显示真实有效的用户ID(UID)和组ID(GID)。UID 是对一个用户的单一身份标识。组ID（GID）则对应多个UID。
# 当我们想知道某个用户的UID和GID时id命令是非常有用的。一些程序可能需要UID/GID来运行。id使我们更加容易地找出用户的UID以GID而不必在/etc/group文件中搜寻。
id
# uid=501(yashi) gid=20(staff) groups=20(staff),12(everyone),61(localaccounts),79(_appserverusr),80(admin),81(_appserveradm),98(_lpadmin),398(com.apple.access_screensharing),33(_appstore),100(_lpoperator),204(_developer),250(_analyticsusers),395(com.apple.access_ftp),399(com.apple.access_ssh),400(com.apple.access_remote_ae),702(com.apple.sharepoint.group.2),701(com.apple.sharepoint.group.1)