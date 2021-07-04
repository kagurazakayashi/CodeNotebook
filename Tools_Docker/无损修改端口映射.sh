cd /var/lib/docker/containers/<CONTAINER ID>
vi hostconfig.json
# 改:
"PortBindings":{}
# 增:
"PortBindings":{"3306/tcp":[{"HostIp":"","HostPort":"3307"}]}
# "容器" : ["宿主机"]