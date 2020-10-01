#include<stdio.h>
int main()
{
    // 获取 ASCII 码
    // char c;
    // for (int i = 0; i < 5; i++) {
    //     printf("Please input a char:\n");
    //     scanf("%c",&c);
    //     printf("The corresponding ASCII code is %d:\n",c);
    // }
    char c1,c2;
    c1='A'; // 将字符‘A’的ASCII代码65放到c1中
    c2=c1+32; // 将65+32的结果放到c2中
    printf("%c\n",c2); // 用字符形式输出
    printf("%d\n",c2); // 用十进制形式输出
    return 0;
}