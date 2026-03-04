# 建立用户组
# 建立新组 group01 ，缺省组 ID 大于 500 和其它组 ID 。
groupadd group01
# 指定组号 -g
groupadd -g 503 group01

# 把用户加入组
usermod -aG 组名 用户名
