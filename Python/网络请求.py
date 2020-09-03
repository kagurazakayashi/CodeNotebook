# GET请求：

# python2.7:
import urllib,urllib2
url='http://192.168.199.1:8000/mainsugar/loginGET/'
textmod ={'user':'admin','password':'admin'}
textmod = urllib.urlencode(textmod)
print(textmod)
#输出内容:password=admin&user=admin
req = urllib2.Request(url = '%s%s%s' % (url,'?',textmod))
res = urllib2.urlopen(req)
res = res.read()
print(res)
#输出内容:登录成功

# python3.5:
from urllib import parse,request
textmod={'user':'admin','password':'admin'}
textmod = parse.urlencode(textmod)
print(textmod)
#输出内容:user=admin&password=admin
header_dict = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko'}
url='http://192.168.199.1:8000/mainsugar/loginGET/'
req = request.Request(url='%s%s%s' % (url,'?',textmod),headers=header_dict)
res = request.urlopen(req)
res = res.read()
print(res)
#输出内容(python3默认获取到的是16进制'bytes'类型数据 Unicode编码，如果如需可读输出则需decode解码成对应编码):b'\xe7\x99\xbb\xe5\xbd\x95\xe6\x88\x90\xe5\x8a\x9f'
print(res.decode(encoding='utf-8'))
#输出内容:登录成功

# POST请求：

# python2.7:
import json,urllib2
textmod={"jsonrpc": "2.0","method":"user.login","params":{"user":"admin","password":"zabbix"},"auth": None,"id":1}
textmod = json.dumps(textmod)
print(textmod)
#输出内容:{"params": {"password": "zabbix", "user": "admin"}, "jsonrpc": "2.0", "method": "user.login", "auth": null, "id": 1}
header_dict = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko',"Content-Type": "application/json"}
url='http://192.168.199.10/api_jsonrpc.php'
req = urllib2.Request(url=url,data=textmod,headers=header_dict)
res = urllib2.urlopen(req)
res = res.read()
print(res)
#输出内容:{"jsonrpc":"2.0","result":"2c42e987811c90e0491f45904a67065d","id":1}

# python3.5:
from urllib import parse,request
import json
textmod={"jsonrpc": "2.0","method":"user.login","params":{"user":"admin","password":"zabbix"},"auth": None,"id":1}
#json串数据使用
textmod = json.dumps(textmod).encode(encoding='utf-8')
#普通数据使用
textmod = parse.urlencode(textmod).encode(encoding='utf-8')
print(textmod)
#输出内容:b'{"params": {"user": "admin", "password": "zabbix"}, "auth": null, "method": "user.login", "jsonrpc": "2.0", "id": 1}'
header_dict = {'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko',"Content-Type": "application/json"}
url='http://192.168.199.10/api_jsonrpc.php'
req = request.Request(url=url,data=textmod,headers=header_dict)
res = request.urlopen(req)
res = res.read()
print(res)
#输出内容:b'{"jsonrpc":"2.0","result":"37d991fd583e91a0cfae6142d8d59d7e","id":1}'
print(res.decode(encoding='utf-8'))
#输出内容:{"jsonrpc":"2.0","result":"37d991fd583e91a0cfae6142d8d59d7e","id":1}

# cookie的使用（python3.5）：

from urllib import request,parse
from http import cookiejar
#创建cookie处理器
cj = http.cookiejar.CookieJar()
opener = request.build_opener(request.HTTPCookieProcessor(cj), request.HTTPHandler)
request.install_opener(opener)
#下面进行正常请求
# ......

# https://www.cnblogs.com/goldd/p/5457229.html


# 使用代理
# 设置网址和代理服务器
url = 'https://www.google.com/'
proxies = {
  "http": "http://user:password@112.25.41.136:80",
  "https": "http://user:password@112.25.41.136:80",
}
proxy = urllib.request.ProxyHandler(proxies)
# 创建全局默认opener对象使urlopen()使用opener
opener = urllib.request.build_opener(proxy, urllib.request.HTTPHandler)
urllib.request.install_opener(opener)
data = urllib.request.urlopen(url).read().decode('utf-8')