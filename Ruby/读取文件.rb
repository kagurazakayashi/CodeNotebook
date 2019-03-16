# 一个字一个字的读入和写入, b:二进制
rFile = File.new(file_path, "rb")
wFile = File.new(@outfile, "ab")
read_file = rFile.sysread(@mem)
wFile.syswrite(read_file)

#Ruby 读取文件
#方法一
file = File.open("/Users/Desktop/demo.txt","r") 
while line = file.gets
    puts line
end
#方法二
File.open("/Users/Desktop/demo.txt","r").each_line do |line|
    puts line
end

#Ruby 写入文件 
File.open("/Users/Desktop/demo.txt","a+") do |f|
    f.puts "hi"
end

# 模式	描述
# r	只读模式。文件指针被放置在文件的开头。这是默认模式。
# r+	读写模式。文件指针被放置在文件的开头。
# w	只写模式。如果文件存在，则重写文件。如果文件不存在，则创建一个新文件用于写入。
# w+	读写模式。如果文件存在，则重写已存在的文件。如果文件不存在，则创建一个新文件用于读写。
# a	只写模式。如果文件存在，则文件指针被放置在文件的末尾。也就是说，文件是追加模式。如果文件不存在，则创建一个新文件用于写入。
# a+	读写模式。如果文件存在，则文件指针被放置在文件的末尾。也就是说，文件是追加模式。如果文件不存在，则创建一个新文件用于读写。

# https://blog.csdn.net/XIAO_XIAO_C/article/details/73603740