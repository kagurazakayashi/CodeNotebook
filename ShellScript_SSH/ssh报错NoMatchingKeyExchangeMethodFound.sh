# no matching key exchange method found
sudo vim /etc/ssh/ssh_config
# 添加：
MACs hmac-md5,hmac-sha1,umac-64@openssh.com,hmac-ripemd160
HostkeyAlgorithms ssh-dss,ssh-rsa
KexAlgorithms +diffie-hellman-group1-sha1


vim ~/.ssh/config
# 添加：
Host 192.168.117.101 #IP
    KexAlgorithms +diffie-hellman-group1-sha1
    