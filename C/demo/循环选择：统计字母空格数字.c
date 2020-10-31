/*
输入一行字符，分别统计出其中英文字母、空格、数字和其它字符的个数。
*/
#include <stdio.h>
int main()
{
    char c;
    int nA, nSpace, nDigital, nOthers;
    nA = 0, nSpace = 0, nDigital = 0, nOthers = 0;
    for (c = getchar(); c != '\n'; c = getchar())
    {
        if (c >= 'A' && c <= 'Z' || c >= 'a' && c <= 'z')
            nA++;
        else if (c == ' ')
            nSpace++;
        else if (c >= '0' && c <= '9')
            nDigital++;
        else
            nOthers++;
    }
    printf("字母 %d 个\n", nA);
    printf("空格 %d 个\n", nSpace);
    printf("数字 %d 个\n", nDigital);
    printf("其它 %d 个\n", nOthers);
    return 0;
}
/*
输入： I Love Yashi!123457654321$%^
输出：
字母 10 个
空格 2 个
数字 12 个
其它 4 个
*/