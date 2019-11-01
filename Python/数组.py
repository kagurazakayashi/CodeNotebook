book = ['xiao zhu pei qi','xiao ji qiu qiu','tang shi san bai shou']  # 定义book数组

book.insert(0,'bu yi yang de ka mei la')  #.insert(x,'xx') 在指定位置添加，x/第几位 ， 'xx'/添加的内容

book.append('e ma ma tong yao') #.append('') 在末尾添加

book[2]='pei qi going swimming' #修改第二个位置为'pei qi going swimming'

book.pop() #删除末尾
book.pop(0) #删除指定位置的内容，0-x

# 往列表里添加元素
#
# append() : 向数组里面添加新元素  例:array.append('AAA') array代表某个自定义的列表
#
# extend()  :  向列表里面田间新元素 例:array.append(['AAA','BBB']) array代表某个自定义的列表
#
# insert :  向列表里面田间新元素 例:array.insert(0,'AAA') array代表某个自定义的列表 0 代表插入的位置，列表的索引值
#
# 从列表里删除元素
#
# remove() : 从列表里删除元素 例:array.remove('AAA') array代表某个自定义的列表 括号里面填写的是元素名
#
# del : del是一个删除语句  例:del  array[index]
#
# pop()  :  主要用来做删除列表中的指定对象,pop()括号内参数是，要删除对象的python list 索引。如果为空则默认为-1最后一项。


# 遍历：
for key in book.keys():
    print(key)
for value in book.values():
    print (value)
for item in book.items():
    print(item)
for key,value in book.items():
    print(key,value)
for (key,value) in book.items():
    print(key,value)