# 批量操作 Docker
#!/bin/bash

# 停止所有的container，这样才能够删除其中的images：
docker stop $(docker ps -a -q)
# 如果想要删除所有container的话再加一个指令：
docker rm $(docker ps -a -q)
# 想要删除untagged imag/es，也就是那些id为<None>的image的话可以用
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
# 要删除全部image的话
docker rmi $(docker images -q)
# 删除所有未使用的虚拟盘
docker volume prune

# 批量停止所有Docker容器.sh
docker stop $(docker ps -q)

# 批量阻止所有Docker容器自启动.sh
docker update --restart=no $(docker ps -aq)

# 批量导出所有Docker容器到当前目录.sh
for id in $(docker ps -aq); do
  name=$(docker inspect --format='{{.Name}}' $id | sed 's/\///g')
  echo "正在导出容器：$name ..."
  docker export -o ${name}.tar $id
done

# 批量导出所有容器到当前目录：带时间戳和压缩.sh
for id in $(docker ps -aq); do
  name=$(docker inspect --format='{{.Name}}' $id | sed 's/\///g')
  timestamp=$(date +%Y%m%d_%H%M%S)
  echo "正在导出容器：$name ..."
  docker export "$id" | xz -z -e -9 -T 0 -v > "${name}_${timestamp}.tar.xz"
done
echo "所有容器已导出"

# 从当前文件夹批量导入所有tarxz容器.sh
# 批量导入当前目录下的 .tar.xz 为同名 Docker 镜像
# 例：nginx_20251029.tar.xz -> 镜像名: nginx_20251029
set -e
shopt -s nullglob
files=( ./*.tar.xz )
for f in "${files[@]}"; do
  img="$(basename "$f" .tar.xz)"
  echo "导入: $f -> 镜像: $img"
  xz -d -c -v "$f" | docker import - "$img" >/dev/null
  echo "完成: $img"
done
echo "全部导入完成。"

# 批量导出所有Docker镜像到当前目录.sh
#!/bin/bash
# 批量导出所有 Docker 镜像为 .tar.xz 文件
# 例：nginx:latest -> nginx_latest.tar.xz
set -e
for img in $(docker images --format '{{.Repository}}:{{.Tag}}' | grep -v '<none>'); do
  safe_name=$(echo "$img" | tr ':/' '__')
  echo "导出镜像: $img -> $safe_name.tar.xz"
  docker save "$img" | xz -z -e -9 -T 0 -v > "${safe_name}.tar.xz"
done
echo "所有镜像已导出"

# 从当前文件夹批量导入所有tarxz镜像.sh
set -e
shopt -s nullglob
files=( ./*.tar.xz )
for f in "${files[@]}"; do
  img="$(basename "$f" .tar.xz)"
  echo "导入: $f -> 镜像: $img"
  xz -d -c -v "$f" | docker import - "$img" >/dev/null
  echo "完成: $img"
done
echo "全部导入完成。"

# 将每一个子文件夹分别压缩成tarxz
cd /var/lib/docker/volumes/
for dir in */; do
  tar -cf - "$dir" | xz -z -e -9 -T 0 -v > "~/bak/${dir%/}.tar.xz"
done
