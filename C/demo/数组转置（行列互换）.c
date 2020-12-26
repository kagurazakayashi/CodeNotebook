/*
写一个函数，使给定的一个 3 × 3 的二维整型数组转置，即行列互换。
*/
#include <stdio.h>
#define N 3
int array[3][3] = {1, 2, 3, 4, 5, 6, 7, 8, 9};
int main()
{
    void convert();
    int i, j;
    for (i = 0; i < 3; i++)
    {
        for (j = 0; j < 3; j++)
            printf("%5d", array[i][j]);
        printf("\n");
    }
    convert(array);
    printf("\n");
    for (i = 0; i < 3; i++)
    {
        for (j = 0; j < 3; j++)
            printf("%5d", array[i][j]);
        printf("\n");
    }
    return 0;
}
void convert()
{
    int i, j, t;
    for (i = 0; i < N; i++) // 行列替换
    {
        for (j = i + 1; j < N; j++)
        {
            t = array[i][j];
            array[i][j] = array[j][i];
            array[j][i] = t;
        }
    }
}
/*
    1    2    3
    4    5    6
    7    8    9

    1    4    7
    2    5    8
    3    6    9
*/