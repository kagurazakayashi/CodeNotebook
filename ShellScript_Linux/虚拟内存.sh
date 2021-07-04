# 分页文件方式
dd if=/dev/zero of=/pagefile.sys bs=1k count=4000000 # 4GB整
mkswap /pagefile.sys
swapon /pagefile.sys
chmod 0600 /pagefile.sys
swapon -s
echo "/pagefile.sys swap swap defaults 0 0" >> /etc/fstab
free -m
grep SwapTotal /proc/meminfo

swapoff /pagefile.sys
rm -f /pagefile.sys
vim /etc/fstab

# 1. 添加swap文件大小为2G
# 默认情况下， of=/swapfile 即swapfile文件创建在/var/目录下。 
# 若我在创建在/opt/image/目录下， 则下面所有的操作里有/swapfile的都要改为/opt/image/swap
dd if=/dev/zero of=/swapfile bs=1k count=2048000
# 2. 创建SWAP文件
mkswap /swapfile
# 3. 激活SWAP文件
swapon /swapfile
# 4. 查看SWAP信息是否正确
swapon -s
# 5. 添加到fstab文件中让系统引导时自动启动
# 注意， 这里是采用了swapfile文件的默认路径， 即/var/swapfile。若你上面的操作中swapfile文件不是在/var/目录下， 则下面的/var/swapfile也要相应修改为自己设写的。
echo "/var/swapfile swap swap defaults 0 0" >> /etc/fstab
# 6. 用命令free检查2G交换分区生效
free -m
# 或者， 检查meminfo文件
grep SwapTotal  /proc/meminfo

# - 删除：
# 7. 释放SWAP文件
swapoff /swapfile
# 8. 删除SWAP文件
rm -fr /swapfile
# 9. 取消自动挂载SWAP文件
vim /etc/fstab


# 物理分区方式
# 1.在sdb上分5个区,每个区大小为500M,采用MBR分区方式,挂载到/mnt/disk1-5目录,
# sdb1采用设备文件方式挂载
# sdb2采用uuid方式挂载
# sdb3采用label方式挂载
# 其他分区随意
fdisk -l  /dev/sdb        fdisk -cu /dev/sdb              :m n  ........
mkfs -t  ext4 /dev/sdb1
mkfs -t ext4  /dev/sdb2
mkfs -t ext4 -L DADA5 /dev/sdb5
mkfs -t ext4 /dev/sdb6
mkfs -t ext4 /dev/sdb7
mount -t  /dev/sdb1  /mnt/disk1
mount -t  UUID="......"  /mnt/disk2
mount -t  label="......"  /mnt/disk3
mount -t  /dev/sdb6  /mnt/disk4
mount -t  /dev/sdb7  /mnt/disk5
#/dev/sdB1      /mnt/disk1     ext4    defaults 0 0
#UUID=49ede8aa-d8bb-4a59-b436-1f91175e9c94  /mnt/disk2 ext4 defaults 0 0
#label=data5         /mnt/disk3 ext4 defaults 0 0
#/dev/sda6       /mnt/disk4      ext4    defaults 0 0
#/dev/sdb7       /mnt/disk5      ext4    defaults 0 0
# 回到用户目录：partx -a /dev/sda  两次（仅仅是当sdb中之前有分区时，加入新建的才要输）
# 2.扩展系统swap分区,分别采用fdisk和dd做,分区大小500M,文件大小500M
free  #查看内存和swap的信息
# 方法1: 使用传统分区fdisk
# 1.分区
fdisk -cu /dev/xvdc
# 2.将分区制作成swap分区
mkswap /dev/xvdc
# 3.挂载 
swapon  /dev/xvdc #挂载
swapoff /dev/xvdc #卸载
# 4.写入 vi /etc/fstab
# /dev/xvdc swap swap defaults 0 0
# 方法2: 使用dd生成大文件
# 1.用dd生成一个大文件
dd if=/dev/zero of=/pagefile.sys bs=1M count=1024
# 2.将文件制作成swap分区
mkswap /pagefile.sys
# 3.挂载swap
swapon /pagefile.sys
# 4.写入fstab
vim /etc/fstab
# /pagefile.sys swap swap defaults 0 0


# 设置虚拟内存比例：
# vm.swappiness是Linux内核的一个参数，范围是0～100。它表示实际内存和虚拟内存区域进行数据交换的倾向性大小，数值越大表示倾向性越大，即交换的页面文件越多，反之亦然。一般默认值为60。可用'cat /proc/sys/vm/swappiness’查看。
# 永久配置方法：
sysctl -w vm.swappiness=100
echo vm.swappiness = 100 >> /etc/sysctl.conf

# 临时配置方法：
sysctl -w vm.swappiness=0
# 手动更改/sys/fs/cgroup/memory下子目录对应的memory.swappiness值

# 查看
sysctl vm.swappiness