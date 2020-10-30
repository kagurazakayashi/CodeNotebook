#include <stdio.h>
int main(void)
{
    int i;
    char str[80] = {'\0'};
    scanf("%s", &str); // 收取上一个程序输出的参数
    // 为每个字符数数
    for (i = 0; str[i] != '\0'; i++)
        printf("%d%c", i+1, str[i]);
    printf("\n");
    return 0;
}