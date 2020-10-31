/*
输出菱形图案
*/
#include <stdio.h>
int main()
{
    int i, j, k, row = 3; //row：可以指定行数
    for (i = 0; i <= row; i++)
    {
        for (k = 0; k <= row - i; k++) // k i 反比
        {
            printf(" ");
        }
        for (j = 1; j <= 2 * i + 1; j++) // 正比
            printf("*");
        printf("\n");
    }
    /*
        *
       ***
      *****
     *******
    */
    for (i = row - 1; i >= 0; i--) // -1: 去掉第一行
    {
        for (k = 0; k <= row - i; k++) // k i 反比
        {
            printf(" ");
        }
        for (j = 1; j <= 2 * i + 1; j++) // 正比
            printf("*");
        printf("\n");
    }
    /*
        *
       ***
      *****
     *******
     *******
      *****
       ***
        *
    */
    return 0;
}