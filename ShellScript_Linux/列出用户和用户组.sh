# 所有本地用户（系统 + 普通）
cat /etc/passwd
# 用户名:密码占位:UID:GID:备注:家目录:登录Shell
# UID < 1000（部分发行版是 < 500）：系统用户
# UID >= 1000：普通登录用户

# 只看“可登录用户”: “谁能 ssh 登录”
awk -F: '$7 !~ /(nologin|false)$/ {print $1}' /etc/passwd

# 同时包含本地用户 + LDAP / SSSD / NIS (在企业环境、AD 接入场景)
getent passwd


# 查看所有用户组
# 本地用户组
cat /etc/group
# NSS 方式（推荐）
getent group
# 查看某个用户属于哪些组
id username
# 仅看组名
groups username
# 区分系统组 vs 普通组（阈值因发行版而异，/etc/login.defs 为准）
awk -F: '$3 < 1000 {print $1}' /etc/group
grep -E '^GID_(MIN|MAX)' /etc/login.defs


# 有 home 目录的用户
awk -F: '$6 ~ /^\/home/ {print $1}' /etc/passwd
# 有 shell 且非系统用户
awk -F: '$3 >= 1000 && $7 !~ /(nologin|false)$/ {print $1}' /etc/passwd
# 所有可登录的普通用户
getent passwd | awk -F: '$3 >= 1000 && $7 !~ /(nologin|false)$/ {print $1}'
# 所有 sudo 用户
getent group sudo | cut -d: -f4


# 用户总数
getent passwd | wc -l
# 组总数
getent group | wc -l
