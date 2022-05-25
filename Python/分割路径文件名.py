# 函数	作用	返回值
# os.path.splitext()	分割文件名和扩展名	元组
# os.path.split()	分割路径和文件名	元组

import os

url = "http://localhost/images/logo.png"

(file, ext) = os.path.splitext(url) # 分割文件名和扩展名
print(file) # http://localhost/images/logo
print(ext)  # .png

(path, filename) = os.path.split(url) # 分割路径和文件名
print(filename) # logo.png
print(path)     # http://localhost/images

# https://blog.csdn.net/lilongsy/article/details/99853925