# python的遍历字符串的方式
strs = 'abcd'

# 1）直接进行遍历
for ch in strs:
    print(ch)

# 2)  利用下标遍历
for index, ch in enumerate(strs):
    print(index,end=' ')
    print(ch)

# 3)  利用range进行遍历
for index in range(len(strs)):
    print(strs[index], end=' ')

# 4)  利用迭代器
for ch in iter(strs):
    print(ch)

# https://blog.csdn.net/zy345293721/article/details/89893279