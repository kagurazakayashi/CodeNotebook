# 解密
ffmpeg -allowed_extensions ALL -i local.m3u8 -c copy v.mp4

ffmpeg -allowed_extensions ALL -i http://.m3u8 -vcodec copy -acodec copy -c copy v.mp4

# 加密
# 1、生成公有key
openssl rand 16 > encrypt.key

# 2、生成私有key(16进制)
openssl rand -hex 16

# 3、按照下面格式新建一个encrypt.keyinfo的文件
Key URI  # enc.key的路径，使用http形式
Path to key file  # enc.key文件
Private key  #  上面生成的16进制的私有key

# 举个例子
# http://192.168.1.111:8090/encrypt.key
# /home/Admin/encrypt.key
# 8b4c39c498949536f8d2af1f6fec7d39

4、使用ffmpeg开始分片并加密
#           源视频文件 |单片时长(s) |             key信息文件           | 设置为点播，切片不会变   |                 分片名字          |  m3u8名字
ffmpeg -y -i test.mp4 -hls_time 5 -hls_key_info_file encrypt.keyinfo -hls_playlist_type vod -hls_segment_filename "test_%d.ts" index.m3u8

# https://www.jianshu.com/p/00e7eb104df0