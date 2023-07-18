#!/bin/bash
function pause (){
    # read: usage: read [-ers] [-a array] [-d delim] [-i text] [-n nchars] [-N nchars] [-p prompt] [-t timeout] [-u fd] [name ...]
    echo "按回车键继续..."
    read -p "Press enter to continue..."
}
echo 111
pause
echo 222
