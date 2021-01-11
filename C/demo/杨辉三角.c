// 杨辉三角 10行直角三角 数组省略前后1 左对齐输出数字
#include <stdio.h>
#include <string.h>
#define kLINE 10
int main()
{
    int i = 2, j = 1, num = 0, arr[kLINE][kLINE];
    memset(arr, -1, sizeof(arr));
    for (; i < kLINE; i++)
        for (j = 1; j <= i - 1; j++)
            arr[i][j] = arr[i - 1][j - 1] + arr[i - 1][j];
    printf("1\n");
    for (i = 1; i < kLINE; i++)
    {
        printf("1   "); // 1后面3个空格
        for (j = 1; j <= i; j++)
        {
            num = arr[i][j] * -1;
            printf("%d ", num);
            while (num < (kLINE << 3) + (kLINE << 1)) // * 10
            {
                printf(" ");
                num += (num << 3) + num;
            }
        }
        printf("\n");
    }
    printf("\n");
    return 0;
}