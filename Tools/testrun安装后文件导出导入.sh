# 从 Docker 批量导出指定前缀的 images

#!/bin/bash
image_ids=$(docker images --format "{{.Repository}}:{{.Tag}}" | grep '^test-run/')
echo $image_ids
echo >"hash.txt"
for image_id in $image_ids; do
  file_name="${image_id//[:\/]/_}.tar.xz"
  echo "$image_id > $file_name"
  docker save "$image_id" | xz -z -1 -v -c >"$file_name"
  openssl sha256 "$file_name" | tee -a "hash.txt"
done
7z a -mx1 "testrun.7z" "/usr/local/testrun"
openssl sha256 "testrun.7z" | tee -a "hash.txt"


# 删除

#!/bin/bash
docker images --format "{{.Repository}}:{{.Tag}}" | grep '^test-run/' | while read image; do
  echo "X  $image"
  docker rmi "$image"
done
rm -rf "/usr/local/testrun"


# 导入
openssl sha256 *.xz *.7z
for f in *.xz; do xz -d $f -v -c | docker image load; done
7z x "testrun.7z" -o"/usr/local/"
