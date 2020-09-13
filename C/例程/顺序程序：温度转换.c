#include <stdio.h>
int main()
{
    float c, f;
    printf("请输入华氏度：\n");
    scanf("%f", &f);
    c = 5 * (f - 32) / 9;
    printf("摄氏度是：");
    printf("%f", c);
    return 0;
}