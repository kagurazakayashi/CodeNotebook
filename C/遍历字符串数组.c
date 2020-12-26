#include <stdio.h>

// 遍历字符串数组
int main2()
{
    char a[] = "I am a student";
    char b[15];
    int i, j;
    while (*(a + i) != '\0')
    {
        *(b + i) = *(a + i);
        i++;
    }
    *(b + i) = *(a + i);
    printf("%s\n", b);
    return 0;
}

// 利用指针变量遍历字符串数组
int main()
{
    char a[] = "I am a student";
    char b[15];
    char *pa, *pb;
    pa = a;
    pb = b;
    while (*pa != '\0')
    {
        *pb = *pa;
        pa++;
        pb++;
    }
    *(++pb) = '\0';
    printf("%s\n", b);
    return 0;
}