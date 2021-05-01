// 打开一个文件并返回文件指针: 打开一个文件然后关闭该文件
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
int main()
{

    FILE* fstream;
    char msg[100] = "Hello!I have read this file.";
    fstream=fopen("test.txt","at+");
    /*
    r	以只读方式打开文件，该文件必须存在。
    r+	以读/写方式打开文件，该文件必须存在。
    rb+	以读/写方式打开一个二进制文件，只允许读/写数据。
    rt+	以读/写方式打开一个文本文件，允许读和写。
    w	打开只写文件，若文件存在则长度清为0，即该文件内容消失，若不存在则创建该文件。
    w+	打开可读/写文件，若文件存在则文件长度清为零，即该文件内容会消失。若文件不存在则建立该文件。
    a	以附加的方式打开只写文件。若文件不存在，则会建立该文件，如果文件存在，写入的数据会被加到文件尾，即文件原先的内容会被保留（EOF符保留)。
    a+	以附加方式打开可读/写的文件。若文件不存在，则会建立该文件，如果文件存在，则写入的数据会被加到文件尾后，即文件原先的内容会被保留（原来的EOF符 不保留)。
    wb	以只写方式打开或新建一个二进制文件，只允许写数据。
    wb+	以读/写方式打开或建立一个二进制文件，允许读和写。
    wt+	以读/写方式打开或建立一个文本文件，允许读写。
    at+	以读/写方式打开一个文本文件，允许读或在文本末追加数据。
    ab+	以读/写方式打开一个二进制文件，允许读或在文件末追加数据。
    */
    if(fstream==NULL)
    {
        printf("open file test.txt failed!\n");
        exit(1);
    }
    else
    {
        printf("open file test.txt succeed!\n");
    }
    fclose(fstream);
    return 0;
}
/*
在POSIX 系统，包含Linux 下都会忽略 b 字符。由fopen()所建立的新文件会具有S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH(0666)权限，此文件权限也会参考umask 值。

二进制和文本模式的区别：
在windows系统中，文本模式下，文件以"\r\n"代表换行。若以文本模式打开文件，并用fputs等函数写入换行符"\n"时，函数会自动在"\n"前面加上"\r"。即实际写入文件的是"\r\n" 。
在类Unix/Linux系统中文本模式下，文件以"\n"代表换行。所以Linux系统中在文本模式和二进制模式下并无区别。

http://c.biancheng.net/cpp/html/250.html
*/