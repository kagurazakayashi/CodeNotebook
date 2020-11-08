#include <stdio.h>
int main()
{
    int a[2][3] = {1, 2, 3, 4, 5, 6};
    int b[3][2];
    int i, j;
    for (i = 0; i < 2; i++)
    {
        for (j = 0; j < 3; j++)
        {
            printf("%d ", a[i][j]);
        }
        printf("\n");
    }
    /* 将一个二维数组行和列的元素互换，存到另一个二维数组中。
        [1 2 3]        [1 4]
    a = [4 5 6] -> b = [2 5]
                       [3 6]
    可以定义两个数组：数组a为2行3列，存放指定的6个数
    数组b为3行2列，开始时未赋值
    将a数组中的元素a[i][j]存放到b数组中的b[j][i]元素中
    用嵌套的for循环完成
    */
    for (i = 0; i < 2; i++)
    {
        for (j = 0; j < 3; j++)
        {
            b[j][i] = a[i][j];
        }
    }
    for (i = 0; i < 3; i++)
    {
        for (j = 0; j < 2; j++)
        {
            printf("%d ", b[i][j]);
        }
        printf("\n");
    }
    return 0;
}