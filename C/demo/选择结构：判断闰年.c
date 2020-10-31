/*
例：判断闰年
- 判别某一年是否闰年，用逻辑表达式表示
- 闰年的条件是符合下面二者之一：
    1. 能被4整除，但不能被100整除，如2008
    2. 能被400整除，如2000

- `(year % 4 == 0 && year 100 !=0) || year % 400 == 0`
- 如果表达式值为1，则闰年；否则为非闰年
*/
#include <stdio.h>
int main()
{
    int year;
    printf("Please input the year:\n");
    scanf("%d", &year);
    if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0)
        printf("%d 是闰年", year);
    else
        printf("%d 不是闰年", year);
    return 0;
}