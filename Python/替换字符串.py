#!/usr/bin/python

strtxt = "this is string example....wow!!! this is really string"
print(strtxt.replace("is", "was"))
# thwas was string example....wow!!! thwas was really string
print(strtxt.replace("is", "was", 3)) # 最多3次
# thwas was string example....wow!!! thwas is really string

# 需要注意 replace 不会改变原 string 的内容。
temp_str = 'this is a test'
print(temp_str.replace('is','IS'))
# thIS IS a test
print(temp_str)
# this is a test