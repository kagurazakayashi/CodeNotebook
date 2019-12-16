#!/usr/bin/python3
from urllib import parse,request
import urllib
import bs4
import sys
# 命令行参数：
# python xkcd_dl.py [cn/en] [id]
# 神楽坂雅詩
# pip install beautifulsoup4
# pip install lxml
# pip install html5lib
lang = sys.argv[1]
imgid = sys.argv[2]
print("----- " + imgid + " -----")
web = 'http://xkcd.in'
url = web + '/comic?lg=' + lang + '&id=' + imgid
print("进行网络请求 " + url + " ...")
req = request.Request(url=url)
res = request.urlopen(req)
res = res.read()
# 获取标题
soup = bs4.BeautifulSoup(res,'html5lib')
elems = soup.select('h1')
title = elems[1].getText()
if title == '404':
    print("404：此 ID 没有对应的信息，跳过。")
    quit()
# 获取图片路径
elems = soup.select('img')
imgsrc = elems[0].get('src')
# 下载图片
imgurl = web + imgsrc
filename0 = imgid + "：" + title
filename = filename0.replace('/','_')
jpgfile = filename + ".jpg"
print("创建图像文件 " + jpgfile + " ...")
request.urlretrieve(imgurl,jpgfile)
# 获取简介
elems = soup.select('.comic-details')
details = elems[0].getText()
txtfile = filename + ".txt"
print("创建简介文件 " + txtfile + " ...")
detailstxt = open(txtfile, 'w')
detailstxt.write(details)
detailstxt.close()