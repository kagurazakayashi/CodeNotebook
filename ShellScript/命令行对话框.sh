# 消息框
# 语法：
whiptail --title "<message box title>" --msgbox "<text to show>" <height> <width>
# 实例：
whiptail --title "Message box title" --msgbox " Choose Ok to continue." 10 60

# yes/no对话框
# 语法：
whiptail --title "<dialog box title>" --yesno "<text to show>" <height> <width>
# 实例：
#!/bin/bash
if (whiptail --title "Yes/No Box" --yesno "Choose between Yes and No." 10 60) then
    echo "You chose Yes. Exit status was $?."
else
    echo "You chose No. Exit status was $?."
fi
# 自定义的选项，实例:
#!/bin/bash
if (whiptail --title "Yes/No Box" --yes-button "Man" --no-button "Woman"  --yesno "What is your gender?" 10 60) then
    echo "You chose Man Exit status was $?."
else
    echo "You chose Woman. Exit status was $?."
fi
# 当选择左边选项的时候输出的是0，选择右边选项的时候输出的是1。

# 表单输入框
# 语法：
whiptail --title "<input box title>" --inputbox "<text to show>" <height> <width> <default-text>
# 实例：
#!/bin/bash
NAME=$(whiptail --title "Free-form Input Box" --inputbox "What is your pet's name?" 10 60 Peter 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "Your name is:" $NAME
else
    echo "You chose Cancel."
fi

# 密码输入框
# 语法：
whiptail --title "<password box title>" --passwordbox "<text to show>" <height> <width>
# 实例：
#!/bin/bash
PASSWORD=$(whiptail --title "Password Box" --passwordbox "Enter your password and choose Ok to continue." 10 60 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "Your password is:" $PASSWORD
else
    echo "You chose Cancel."
fi

# 菜单栏 提供一个单项选择的菜单栏
# 语法：
whiptail --title "<menu title>" --menu "<text to show>" <height> <width> <menu height> [ <tag> <item> ] . . .
# 实例：
#!/bin/bash
OPTION=$(whiptail --title "Menu Dialog" --menu "Choose your favorite programming language." 15 60 4 \
"1" "Python" \
"2" "Java" \
"3" "C" \
"4" "PHP"  3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "Your favorite programming language is:" $OPTION
else
    echo "You chose Cancel."
fi

# 单选 radiolist 对话框
# 该对话框是单选对话框，你可以控制默认的选择位置，即使你在脚本中默认选择多个，他也只会输出一个结果
# 语法：
whiptail --title "<radiolist title>" --radiolist "<text to show>" <height> <width> <list height> [ <tag> <item> <status> ] . . .
# 实例：
#!/bin/bash
DISTROS=$(whiptail --title "Test Checklist Dialog" --radiolist \
"What is the Linux distro of your choice?" 15 60 4 \
"debian" "Venerable Debian" ON \
"ubuntu" "Popular Ubuntu" OFF \
"centos" "Stable CentOS" OFF \
"mint" "Rising Star Mint" OFF 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "The chosen distro is:" $DISTROS
else
    echo "You chose Cancel."
fi

# 多选对话框
# 语法：
whiptail --title "<checklist title>" --checklist "<text to show>" <height> <width> <list height> [ <tag> <item> <status> ] . . .
# 实例：
#!/bin/bash
DISTROS=$(whiptail --title "Checklist Dialog" --checklist \
"Choose preferred Linux distros" 15 60 4 \
"debian" "Venerable Debian" ON \
"ubuntu" "Popular Ubuntu" OFF \
"centos" "Stable CentOS" ON \
"mint" "Rising Star Mint" OFF 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "Your favorite distros are:" $DISTROS
else
    echo "You chose Cancel."
fi

# 进度条
# 语法：
whiptail --gauge "<test to show>" <height> <width> <inital percent>
# 实例：
#!/bin/bash
{
    for ((i = 0 ; i <= 100 ; i+=20)); do
        sleep 1
        echo $i
    done
} | whiptail --gauge "Please wait while installing" 6 60 0

# https://www.cnblogs.com/panyouming/p/8511022.html