ls /dev/tty.usb*
minicom -D /dev/tty.usbserial-146110 -b 115200
screen -L /dev/tty.usbserial-146110 115200 # 退出终端: Ctrl+A k

screen -L `ls -1 /dev/tty.usb* | head -n 1` 115200