// 输入一个字符，判别它是否大写字母，如果是，将它转换成小写字母；如果不是，不转换。然后输出最后得到的字符。
// 用条件表达式来处理，当字母是大写时，转换成小写字母，否则不转换。
/*
#include <stdio.h>
int main()
{
    char c;
    scanf("%c", &c);
    c = (c >= 'A' && c <= 'Z') ? (c + 32) : c;
    printf("%c\n", c);
    return 0;
}
*/
#include <stdio.h>
int main()
{
    char c;
    printf("Please input a character:\n");
    c = getchar();
    (c >= 65 && c < 97) ? printf("%c", c + 32) : putchar(c);
    return 0;
}