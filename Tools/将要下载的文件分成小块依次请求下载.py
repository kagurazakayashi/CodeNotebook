# -*- coding: utf-8 -*-
# 将要下载的文件分成小块依次请求下载，用于测试服务器分段下载
# 神楽坂雅詩
# pip3 install urllib2

import sys
import requests
import os

if len(sys.argv) != 4:
    print("参数1：网址；")
    print("参数2：本地文件路径；")
    print("参数3：每次请求限制尺寸。")
    quit()
url = sys.argv[1]
filepath = sys.argv[2]
blocksize = int(sys.argv[3])

if os.path.exists(filepath):
    os.remove(filepath)
# 第一次请求:得到文件总大小
r0 = requests.get(url, stream=True, verify=False)
total_size = int(r0.headers['Content-Length'])
download_size = -1
print('0 : 0 - 0 / '+str(total_size))
print(r0.headers)
r0.close()
i = 0
# 循环请求:每块单独产生一次网络请求
with open(filepath, "ab") as f:
    while total_size > download_size:
        i += 1
        to_size = download_size + blocksize
        if to_size > total_size:
            to_size = total_size
        tdsize = download_size + 1
        print(str(i)+' : '+str(tdsize)+' - '+str(to_size)+' / '+str(total_size))
        download_size += blocksize
        bytesstr = 'bytes='+str(tdsize)+'-'+str(to_size)
        headers = {'Range': bytesstr}
        r = requests.get(url, stream=True, verify=False, headers=headers)
        print(r.headers)
        f.write(r.content)
        pass
f.close()
fsize = os.path.getsize(filepath)
print(str(fsize)+' @ '+str(total_size))
os.system('openssl md5 "'+filepath+'"')