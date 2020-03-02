# 第一步，首先下载java镜像
docker pull java:8
# 第二步，新建一个工作目录，拷贝jar包进去
mkdir mydocker
cd mydocker
copy /xxx/app.jar ./
# 第三步，新建一个Dockerfile文件——
vi Dockerfile

FROM java:8
MAINTAINER freebytes.net
WORKDIR  /app
COPY app.jar /app/app.jar
CMD ["java","-jar","app.jar","-Dfile.encoding=utf-8"]

# FROM java:8 ——表示基于java:8镜像构建
# MAINTAINER freebytes.net ——表示构建作者为 freebytes.net
# WORKDIR /app ——表示指定容器内的工作目录为/app
# COPY ——拷贝app.jar到容器工作目录/app
# CMD ——执行java启动jar的指令。

# 第四步，构建镜像
docker build -t app-docker .
# 表示从当前目录构建镜像，这条命令会把当前目录下文件全部打包发送到docker引擎服务端，然后在服务端根据Dockerfile进行构建操作。

# 构建成功后，启动容器——
docker run -it -p 9013:8088 -–name app -d my-docker
# 根据刚才的Dockerfile配置，容器生成后，必然会在容器根目录下生成app目录，并且app目录下存在app.jar文件，容器执行CMD定义的指令也是基于app目录的。

# 可进入容器内部查看——
docker exec -it app /bin/bash