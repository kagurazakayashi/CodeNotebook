yum install inotify-tools -y

#!/bin/bash
inotifywait -m "/server/" -r -e create -e moved_to -e delete -e modify | while read path action file; do
    echo "The file '$file' appeared in directory '$path' via '$action'."
    if [ "$file" == "test.txt" ];then
        echo "OK";
    fi
done
# 输出： 自己执行的内容

inotifywait -mrq --timefmt '%d/%m/%y/%H:%M' --format '%T %w %f' -e modify,delete,create,attrib "/server/"
# 输出： 时间 目录 文件名

inotifywait -mrq -e modify,delete,create,attrib "/server/"
# 输出： 目录 操作 文件名

# inotifywait命令参数
# -m        是要持续监视变化。
# -r        使用递归形式监视目录。
# -q        减少冗余信息，只打印出需要的信息。
# -e        指定要监视的事件列表。
# --timefmt 是指定时间的输出格式。
# --format  指定文件变化的详细信息。

# 可监听的事件
# access    访问，读取文件。
# modify    修改，文件内容被修改。
# attrib    属性，文件元数据被修改。
# move      移动，对文件进行移动操作。
# create    创建，生成新文件
# open      打开，对文件进行打开操作。
# close     关闭，对文件进行关闭操作。
# delete    删除，文件被删除。