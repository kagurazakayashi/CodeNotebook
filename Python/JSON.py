# 以下实例将数组编码为 JSON 格式数据：
import json
data = [ { 'a' : 1, 'b' : 2, 'c' : 3, 'd' : 4, 'e' : 5 } ]
jsondata = json.dumps(data) # 数组→字符串
print jsondata
# 以上代码执行结果为：
[{"a": 1, "c": 3, "b": 2, "e": 5, "d": 4}]
# 使用参数让 JSON 数据格式化输出：
import json
print json.dumps({'a': 'Runoob', 'b': 7}, sort_keys=True, indent=4, separators=(',', ': '))
{
    "a": "Runoob",
    "b": 7
}

# 以下实例展示了Python 如何解码 JSON 对象：
import json
jsonData = '{"a":1,"b":2,"c":3,"d":4,"e":5}'
text = json.loads(jsonData) # 字符串→数组
print text
# 以上代码执行结果为：
{u'a': 1, u'c': 3, u'b': 2, u'e': 5, u'd': 4}

# 使用第三方库：Demjson
# Demjson 是 python 的第三方模块库，可用于编码和解码 JSON 数据，包含了 JSONLint 的格式化及校验功能。
import demjson

demjson.encode( ['one',42,True,None] )    # From Python to JSON
# '["one",42,true,null]'

demjson.decode( '["one",42,true,null]' )  # From JSON to Python
# ['one', 42, True, None]

# https://www.runoob.com/python/python-json.html
