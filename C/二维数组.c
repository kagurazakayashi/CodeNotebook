/*
二维数组定义的一般形式为
类型符 数组名[常量表达式][常量表达式];
如：float a[3][4],b[5][10];
二维数组可被看作是一种特殊的一维数组：
它的元素又是一个一维数组
例如，把a看作是一个一维数组，它有3个元素：
a[0]、a[1]、a[2]
每个元素又是一个包含4个元素的一维数组

逻辑存储
a[0] : a[0][0] a[0][1] a[0][2] a[0][3] ->
a[1] : a[1][0] a[1][1] a[1][2] a[1][3] ->
a[2] : a[2][0] a[2][1] a[2][2] a[2][3] ->

二维数组初始化
int a[3][4] = {{1, 2, 3, 4}, {5, 6, 7, 8}, {9, 10, 11, 12}};
int a[3][4] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
int a[3][4] = {{1}, {5}, {9}};
    //等价于
int a[3][4] = {{1, 0, 0, 0}, {5, 0, 0, 0}, {9, 0, 0, 0}};
int a[3][4] = {{1}, {5, 6}};
    //相当于
int a[3][4] = {{1}, {5, 6}, {0}};

int a[3][4] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
//等价于：
int a[][4] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
int a[][4] = {{0, 0, 3}, {}, {0, 10}}; //合法

引用二维数组的元素
二维数组元素的表示形式为：
数组名［下标］［下标］
b[1][2]=a[2][3]/2; //合法
for(i=0;i<m;i++) printf(“%d,%d\n”,a[i][0],a[0][i]); //合法

*/
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
    return 0;
}