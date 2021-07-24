# 字符串转数组
str = '1,2,3'
arr = str.split(',')

# 数组转字符串
arr = ['a','b']
str1 = ','.join(arr)

# 字符串转list
str3 = "www.google.com"
list3 = str3.split(".")
print list3 # ['www', 'google', 'com']

# list转字符串
str5 = ".".join(list3)
print str5 # www.google.com