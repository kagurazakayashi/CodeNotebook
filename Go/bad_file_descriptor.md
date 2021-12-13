`file, err := os.Open("a.txt")`
此时运行就会出现错误 `write a.txt: bad file descriptor` 。这是什么原因呢？其实这和 `os.Open()` 函数有关

OpenFile函数的第二个传入参数的值可以是：

| 参数名   | 含义 |
| -------- | ---- |
| O_RDONLY | 打开只读文件 |
| O_WRONLY | 打开只写文件 |
| O_RDWR   | 打开既可以读取又可以写入文件 |
| O_APPEND | 写入文件时将数据追加到文件尾部 |
| O_CREATE | 如果文件不存在，则创建一个新的文件 |
| O_EXCL   | 文件必须不存在，然后会创建一个新的文件 |
| O_SYNC   | 打开同步I/0 |
| O_TRUNC  | 文件打开时可以截断  |

修改后： `file, err := os.OpenFile("a.txt", os.O_APPEND|os.O_WRONLY, os.ModeAppend)`

<!-- https://www.jb51.net/article/155949.htm -->