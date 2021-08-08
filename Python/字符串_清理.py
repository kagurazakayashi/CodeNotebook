# strip() 方法用于移除字符串头尾指定的字符（默认为空格或换行符）或字符序列。
string = "  * it is blank space test *  "
print(string.strip()) # 删除两边空格
print(string.lstrip()) # 删除左边空格
print(string.rstrip()) # 删除右边空格