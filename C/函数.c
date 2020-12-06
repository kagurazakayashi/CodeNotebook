#include <stdio.h>
int main()
{
    void printfStar(); // 必须先定义后使用
    void printfMessage();
    printfStar(30); //实参
    printfMessage();
    printfStar(60);
    return 0;
}
void printfStar(int starnum) //形参
{
    for (int i = 0; i < starnum; i++)
    {
        printf("*");
    }
    printf("\n");
}
void printfMessage()
{
    printf("hi");
}

// 函数的递归调用
int f(int x) // F1 -> F2(克隆了F1的副本) 层层克隆，层层返回，消耗内存
{
    int y, z;
    z = f(y);
    return (2 * z);
}