docker search tomcat
docker pull tomcat:latest

docker run --name tomcat -p 8080:8080 -v $PWD/test:/usr/local/tomcat/webapps/test -d tomcat
# -p 8080:8080：将容器的 8080 端口映射到主机的 8080 端口。
# -v $PWD/test:/usr/local/tomcat/webapps/test：将主机中当前目录下的 test 挂载到容器的 /test。

docker run --name tomcat -p 8080:8080 -v /tomcatapp:/usr/local/tomcat/webapps -d tomcat:latest