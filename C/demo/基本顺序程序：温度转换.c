// 顺序程序设计
#include <stdio.h>
int main()
{
    float c, f; // 定义f和c为单精度浮点型变量
    printf("请输入华氏度：\n"); // 指定f的值
    scanf("%f", &f);
    c = 5 * (f - 32) / 9; // 计算c的值
    printf("摄氏度是：");
    printf("%f", c); // 输出c的值
    return 0;
}