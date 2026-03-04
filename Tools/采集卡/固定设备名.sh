# /dev/video* 每次重启里面代表的设备总是变化怎么办
# 采集卡固定一个永不变化的名字

# 首先获取设备的唯一信息（如 vendor/product ID）
lsusb
# Bus 001 Device 005: ID 2b89:5854 MACROSILICON UGREEN 25854
# ID idVendor:idProduct

# 写 udev 规则，给它固定名字
vim /etc/udev/rules.d/99-ugreen25854.rules
# SUBSYSTEM=="video4linux", ATTRS{idVendor}=="2b89", ATTRS{idProduct}=="5854", SYMLINK+="ugreen-capture"

# SUBSYSTEM=="video4linux" → 匹配 /dev/video* 类设备
# ATTRS{idVendor}=="2b89" → 你的设备 USB Vendor
# ATTRS{idProduct}=="5854" → Product
# SYMLINK+="ugreen-capture" → 创建 /dev/ugreen-capture 指向真实的 /dev/videoX

# 让规则生效
udevadm control --reload-rules
udevadm trigger
ls -l /dev/ugreen-capture
