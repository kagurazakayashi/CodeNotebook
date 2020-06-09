# 下载单个文件
aria2c https://url.com/1.zip

# 下载并改名
aria2c -o 2.zip https://url.com/1.zip

# 下载限速
aria2c --max-download-limit=500k https://url.com/1.zip

# 下载多个文件
aria2c -Z https://url.com/1.zip https://url.com/2.zip

# 扩展下载地址
aria2c -Z -P "http://host/image{1,2,3}_{A,B,C}.png"
# http://host/image1_A.png
# http://host/image1_B.png
# http://host/image1_C.png
# http://host/image2_A.png
# http://host/image2_B.png
# http://host/image2_C.png
# http://host/image3_A.png
# http://host/image3_B.png
# http://host/image3_C.png

# 续传未完成的下载
aria2c -c https://url.com/1.zip

# 读取下载列表（将每一个 URL 存储在单独的行中。）
aria2c -i list.txt

# 每个主机使用2个连接来下载
aria2c -x2 https://url.com/1.zip

# 登录
aria2c --http-user=xxx --http-password=xxx https://url.com/1.zip
aria2c --ftp-user=xxx --ftp-password=xxx ftp://url.com/1.zip

# 显示帮助
man aria2c
aria2c -h