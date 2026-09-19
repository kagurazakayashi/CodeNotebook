# SSH两步验证 切换至 Google Authenticator（TOTP）

# 安装模块
apt install libpam-google-authenticator -y

# 为每个用户生成验证码密钥
google-authenticator

# Do you want authentication tokens to be time-based (y/n)
# 你是否希望认证令牌（验证码）基于**时间（TOTP）**生成？选择 y，这正是 Google Authenticator、Authy、1Password 等 App 所支持的标准方式。

# Do you want to disallow multiple uses of the same authentication token?
# 每个验证码只能用一次，防止中间人攻击？选择 y，增加安全性（防止一个验证码在30秒内被重复使用）

# Do you want to increase the window of allowed tokens from 3 to 17?
# 增加容错时间范围，从 ±30 秒变成 ±4 分钟（用于解决客户端和服务器时间不同步问题）？n，不建议扩大。

# Do you want to enable rate-limiting?
# 是否启用每 30 秒最多允许 3 次尝试的速率限制？选择 y，防止暴力破解验证码，属于合理防护措施。

# 在 /etc/pam.d/sshd
vim /etc/pam.d/sshd
# 开头添加：auth required pam_google_authenticator.so
# 注释掉： @include common-auth

# 修改 SSH 配置
vim /etc/ssh/sshd_config
# ChallengeResponseAuthentication yes
# 如果使用密钥登录
# AuthenticationMethods publickey,keyboard-interactive
# 如果使用密码登录
# AuthenticationMethods password,keyboard-interactive
# 修改 no 为 yes:
# UsePAM yes
# KbdInteractiveAuthentication yes

# 设置配置为只读
chmod 400 ~/.google_authenticator

# 检查 SSH 配置文件语法是否正确
sshd -t

# 重启服务
systemctl restart ssh
