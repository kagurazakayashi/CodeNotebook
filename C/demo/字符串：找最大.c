/*
有3个字符串,要求找出其中最大者。
*/
#include <stdio.h>
#include <string.h>
int main()
{
    char str1[] = "China", str2[] = "Japan", str3[] = "India";
    char string[10];
    if (strcmp(str1, str2) > 0)
        strcpy(string, str1);
    else
        strcpy(string, str2);
    if (strcmp(string, str3) < 0)
        strcpy(string, str3);
    puts(string); // Japan
    return 0;
}

/*
二维数组方式
思路：设一个二维的字符数组str,大小为3×10。每一行存放一个字符串
    char str[3][10];
可以把str[0],str[1],str[2]看作3个一维字符数组，可以把它们如同一维数组那样进行处理
    for (i=0;i<3;i++) gets (str[i]);
str[0] C h i n a \0 \0 \0 \0 \0
str[1] J a p a n \0 \0 \0 \0 \0
str[2] I n d i a \0 \0 \0 \0 \0
*/
#include <stdio.h>
#include <string.h>
int main()
{
    char str[3][10];
    char string[10];
    int i;
    for (i = 0; i < 3; i++)
        gets(str[i]);

    // 经过三次两两比较,就可得到值最大者,把它放在一维字符数组string中
    if (strcmp(str[0], str[1]) > 0)
        strcpy(string, str[0]);
    else
        strcpy(string, str[1]);
    if (strcmp(str[2], string) > 0)
        strcpy(string, str[2]);

    printf("\nthe largest:\n%s\n", string);
    return 0;
}