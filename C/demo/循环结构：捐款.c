#include <stdio.h>
// 一共 10 人，募捐到 100 为止
#define PEOPLE 10
#define MAXSUM 100
int main()
{
    float amount, average, total = 0;
    int i;
    for (i = 1; i <= PEOPLE; i++)
    {
        printf("请输入第 %d 个学生的捐款数:", i);
        scanf("%f", &amount);
        total = total + amount;
        if (total >= MAXSUM)
            break;
    }
    if (total < MAXSUM)
        average = total / PEOPLE;
    else
        average = total / i;
    printf("捐款完毕，平均每人捐款 %f \n", average);
    return 0;
}