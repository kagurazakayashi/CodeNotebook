# 1. 安装Beautifulsoup4
# pip install beautifulsoup4
# pip install lxml
# pip install html5lib
# lxml 和 html5lib 是解析器

import bs4

exampleFile = open('example.html')
exampleSoup = bs4.BeautifulSoup(exampleFile.read(),'html5lib')
elems = exampleSoup.select('#author')
type(elems)
print (elems[0].getText())

# BeautifulSoup 使用select 方法寻找元素，类似jquery的css选择器
# 所有为<div>的元素
exampleSoup.select('div')
# id为author的元素
exampleSoup.select('#author')
# class 为notice的元素
exampleSoup.select('.notice')

# http://www.waitingfy.com/archives/1818

# 获取图片src
# 使用 find_all() 方法获取所有的<img>标签
img = soup.find_all('img')
# 得到的结果是一个<img>标签数组，使用 get() 获取<img>的src
src=img[2].get('src')