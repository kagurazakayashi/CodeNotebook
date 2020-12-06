// 求一个 3 × 3 的整型矩阵对角线元素之和。
#include <stdio.h>
int main()
{
    int arr[3][3] = {1, 2, 3, 4, 5, 6, 7, 8, 9};
    /*
    1 2 3
    4 5 6
    7 8 9
    */
    int s = 0;
    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            if (j == i)
                s += arr[i][j];
            else
                continue;
        }
    }
    printf("s = %d\n", s);
    return 0;
}