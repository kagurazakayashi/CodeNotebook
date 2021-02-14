# chown 命令改变文件所有者
# chown <owner>[:<group>] <filename>

# ls: -r-xr--r-- root root 20 Oct 01 14:00 yashi.txt
chown yashiuser:yashigroup /home/yashi/yashi.txt
# ls: -r-xr--r-- yashiuser yashigroup 20 Oct 01 14:00 yashi.txt