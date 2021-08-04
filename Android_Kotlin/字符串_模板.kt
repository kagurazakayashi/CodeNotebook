// 被两个双引号包裹的内容是普通字符串，支持转义字符
var s1 = "abcdef"

// 被一对三引号包裹的内容是原样字符串，不支持转义字符，其中的内容被定义什么样，输出的时候就是什么样。
var s2 = """
abc
def
"""

// 字符串模板格式：${占位字符串}
var s3 = "s1:${s1}, s2:${s2}"