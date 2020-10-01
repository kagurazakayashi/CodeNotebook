//standard input/output
#include <stdio.h>
//函数：完成一个功能，包含两部分：头部和函数体
//声明主函数
int maxf(int x, int y)
{
    return x > y ? x : y;
}
#include <stdio.h>
int main()
{
    int a, b, m; //声明部分
    printf("请输入两个整数：\n"); // \n == 转义字符 == 换行
    scanf("%d%d", &a, &b);
    m = maxf(a, b);
    printf("最大的数字是：");
    printf("max=%d", m);
    return 0;
}