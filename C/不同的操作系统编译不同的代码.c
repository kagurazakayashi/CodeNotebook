// 条件编译
#include <stdio.h>
int main(void)
{
    /*
    #ifdef, #ifndef, #elif, #else, #endif
    #if 宏定义为真实#if才会执行，需要定义为 #define _WIN32 1 才会执行
    #ifdef 只需要定义了_WIN32就可以
    #ifndef 如果没有定义宏，就执行
    */
#ifdef _WIN32 // WIN32, _WIN32
    printf("Windows\n");
#elif __linux__ // linux, unix, linux, unix, __linux, __unux
    printf("Linux\n");
#elif macintosh
    printf("mac OS\n");
#elif __ANDROID__
    printf("Android\n");
#elif __gnu_linux__
    printf("GNU/Linux\n");
#elif __sun // sun, __sun
    printf("solaris\n");
#elif __FreeBSD__
    printf("FreeBSD\n");
#elif __OpenBSD__
    printf("OpenBSD\n");
#else
    printf("OTHER!\n");
#endif
    return 0;
}
/*
查看gcc编译器的预定义宏
$ gcc -dM -E -x c /dev/null |grep -i "unix"
	#define __unix__ 1
	#define __unix 1
	#define unix 1
$ gcc -dM -E -x c /dev/null |grep -i "linux"
	#define __linux 1
	#define __linux__ 1
	#define __gnu_linux__ 1
	#define linux 1
命令 gcc 可以替换成 g++, cpp

在gcc编译工具中
我们可以使用-D选项，动态地定义程序所需要的宏
比如我们可以这样编译 gcc test.c -o test -D _WIN32
这样程序就可以在Windows下运行了（当然，实际情况是在Windows环境下，_WIN32已经被定义） gcc中的-D选项会默认将宏定义为1，如果要定义为其他的值使用等于号如：-D _WIN32=0

在cmake中
我们可以在CMakeLists.txt中写入ADD_DEIFNITIONS(-D _WIN32)来添加程序运行时用到的宏。但是这样，一旦我们需要修改使用的宏，就要修改CMakeLists.txt文件，会很麻烦。
这时我们可以这样做：
在CMakeLists.txt中写入
IF(ENVIRO)
ADD_DEFINITIONS(-D _WIN32)
ENDIF(ENVIRO)
这样，我们可以在使用cmake命令的时候加入-D选项，定义ENVIRO命令如下
cmake -D ENVIRO=1，或者 cmake -D ENVIRO=ON
如果要取消这个定义可以使用：
cmake -D ENVIRO=OFF 或 cmake -D ENVIRO=0 或者cmake -U ENVIRO

https://www.cnblogs.com/qingergege/p/6726692.html
*/