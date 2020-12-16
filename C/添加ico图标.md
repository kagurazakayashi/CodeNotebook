1. 加入图标文件 icon.ico

2. 新建文件 res.rc

`ICON "icon.ico"`

3. 在MinGW或CygWin中使用“windres”命令来将.rc文件编译成目标文件

`windres res.rc res.o`

4. 编译

`g++ main.cpp -o main.exe`

5. 最终生成的main.exe加上.ico图标

`g++ main.cpp demo.o -o main.exe`