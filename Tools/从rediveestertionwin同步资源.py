# -*- coding: utf-8 -*-
#!/usr/bin/python3
# pip3 install beautifulsoup4 lxml html5lib
from urllib import parse, request
from bs4 import BeautifulSoup
import xml.dom.minidom
import os
import html5lib

# 设置网址 模式(1图页2视频页) 下载到文件夹，路径以 / 结尾
url = ['https://redive.estertion.win/card/full/',1,'/Volumes/RamDisk/']

# 设置代理服务器
proxyurl = 'http://127.0.0.1:6152'
proxy = request.ProxyHandler({'http': proxyurl, 'https': proxyurl})
opener = request.build_opener(proxy, request.HTTPHandler)
request.install_opener(opener)
print('已设置代理服务器', proxyurl)

# 设置UA
header_dict = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko',"Content-Type": "application/json"}
req = request.Request(url=url[0],headers=header_dict)

# 连结
print('正在连结', '...')
html = request.urlopen(req).read().decode('utf-8')

print('正在解析 DOM', '...')
soup = BeautifulSoup(html, "html5lib")

script = soup.find("script", text=lambda text: text and "names" in text)
print(script)

if url[1] == 1: #图页
    for item in soup.select(".name"):
        cfile = item.string
        filepath = url[2] + cfile
        if os.path.exists(filepath):
            print('文件已存在:', filepath)
        else:
            print('文件需要下载:', filepath)

# 改为 js 实现，见 js 版