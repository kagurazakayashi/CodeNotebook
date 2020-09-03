# 1、安装BeautifulSoup
# 2、安装第三方html解析器lxml
# 3、安装纯Python实现的html5lib解析器
pip3 install beautifulsoup4 lxml html5lib

# 1、导入bs4库
from bs4 import BeautifulSoup #导入bs4库

# 2、创建包含html代码的字符串
html_str = """
<html><head><title>The Dormouse's story</title></head>
<body>
<p class="title"><b>The Dormouse's stopy</b></p>
<p class="story">Once upon a time there were three little sisters;and their names where
<a href="http://example.com/elsie" class="sister" id="link1"><!--Elsie--></a>
"""

# 创建BeautifulSoup对象
# (1)直接通过字符串方式创建
soup = BeautifulSoup(html_str,'html.parser') #html.parser是解析器，也可是lxml
print(soup.prettify()) #输出soup对象的内容
# (2)通过已有的文件来创建
soup = BeautifulSoup(open('/home/index.html'),features='html.parser')#html.parser是解析器，也可是lxml

# 4、BeautifulSoup对象的种类：BeautifulSoup将复杂HTML文档转换成一个复杂的树形结构，每个节点都是Python对象
# (1)BeautifulSoup：表示的是一个文档的全部内容。大部分时候，可以把它当作Tag对象，是一个特殊的Tag，因为BeautifulSoup对象并不是真正的HTML和XML，所以没有name和attribute属性
# (2)Tag：与XML或HTML原生文档中的Tag相同，通俗讲就是标记
# 如：
# 抽取title：
print(soup.title)
# 抽取a ： 
print(soup.a)
# 抽取p：
print(soup.p)
# Tag中有两个重要的属性：name和attributes。每个Tag都有自己的名字，通过.name来获取
print(soup.title.name)
# 操作Tag属性的方法和操作字典相同
# 如：<p class='p1'>Hello World</p>
print(soup.p['class'])
# 也可以直接“点”取属性，如 .attrs 获取Tag中所有属性
print(soup.p.attrs)
# (3)NavigableString：获取标记内部的文字.string
# BeautifulSoup用 NavigableString类来封装Tag中的字符串，一个 NavigableString字符串与Python中的Unicode字符串相同，通过unicode()方法可以直接将 NavigableString对象转换成Unicode字符串 如：
u_string = unicode(soup.p.string)
# (4)Comment：对于一些特殊对象，如果不清楚这个标记.string的情况下，可能造成数据提取混乱。因此在提取字符串时，可以判断下类型：
if type(soup.a.string) == bs4.element.Comment:
    print(soup.a.string)

# 5、遍历文档
# (1)子节点：
# A、对于直接子节点可以通过 .contents 和 .children来访问
# .contents #将Tag子节点以列表的方式输出
print(soup.head.contents)
# .children #返回一个生成器，对Tag子节点进行循环
for child in soup.head.children:
    print(child)
# B、获取子节点的内容
# .string #如果标记里没有标记了，则返回内容；如果标记里只有一个唯一的标记，则返回最里面的内容；如果包含多个子节点，Tag无法确定.string方法应该返回哪个时，则返回None
# .strings #主要应用于Tag中包含多个字符串的情况，可以进行循环遍历
for str in soup.strings:
    print(repr(str))
# .stripped_string #可以去掉字符串中包含的空格或空行
for str in soup.stripped_strings:
    print(repr(str))
# (2)父节点
# A、通过.parent属性来获取某个元素的父节点，如：
print(soup.title.parent)
# B、通过.parents属性可以递归得到元素的所有父辈节点
for parent in soup.a.parents:
if parent is None:
    print(parent)
else:
    print(parent.name)
# (3)兄弟节点
# . next_sibling #获取该节点的下一个兄弟节点
# . previous_sibling #获取该节点的上一个兄弟节点
# (4)前后节点
# . next_elements #获得该节点前面的所有节点
# . previous_elements #获得该节点后面的所有节点

# 6、搜索文档树
# (1)
find_all(name,attrs,recursive,text,**kwargs)
# A、name参数：查找名字为name的标记
# print(soup.find_all(''''b))
# B、text参数：查找文档中字符串的内容
# C、 recursive参数：检索当前Tag的所有子孙节点时，若只想找直接子节点， 该参数设置为False

# 7、CSS选择器：使用soup.select()函数
# (1)通过标记名查找
print(soup.select("title"))
# (2)通过Tag的class属性值查找
print(soup.select(".sister"))
# (3)通过Tag的id属性值查找
print(soup.select("#sister"))
# (4)通过是否存在某个属性查找
print(soup.select("a[href]"))
# (5)通过属性值查找
print(soup.select('a[href="http://exam.com"]'))

# https://www.cnblogs.com/lone5wolf/p/10881395.html