# 字符串前缀

# unicode字符串
# 不是仅仅是针对中文, 可以针对任何的字符串，代表是对字符串进行unicode编码。
# 一般英文字符在使用各种编码下, 基本都可以正常解析, 所以一般不带u；但是中文, 必须表明所需编码, 否则一旦编码转换就会出现乱码。
# 建议所有编码方式采用utf8
strv = u"aa\na"
strv = U"aa\na"

# 非转义的原始字符串
# 与普通字符相比，其他相对特殊的字符，其中可能包含转义字符，即那些，反斜杠加上对应字母，表示对应的特殊含义的，比如最常见的”\n”表示换行，”\t”表示Tab等。而如果是以r开头，那么说明后面的字符，都是普通的字符了，即如果是“\n”那么表示一个反斜杠字符，一个字母n，而不是表示换行了。
# 以r开头的字符，常用于正则表达式，对应着re模块。
strv = r"aa\na"
strv = R"aa\na"

# bytes
# python3.x里默认的str是(py2.x里的)unicode, bytes是(py2.x)的str, b”“前缀代表的就是bytes
strv = b"aa\na"
strv = B"aa\na"

# 互相转换

# python bytes和str两种类型可以通过函数encode()和decode()相互转换，
# str→bytes: encode()方法。str通过encode()方法可以转换为bytes。
# bytes→str: decode()方法。如果我们从网络或磁盘上读取了字节流，那么读到的数据就是bytes。要把bytes变为str，就需要用decode()方法。

# bytes object
b = b"example"

# str object
s = "example"

# str to bytes
bytes(s, encoding = "utf8")

# bytes to str
str(b, encoding = "utf-8")

# an alternative method
# str to bytes
str.encode(s)

# bytes to str
bytes.decode(b)