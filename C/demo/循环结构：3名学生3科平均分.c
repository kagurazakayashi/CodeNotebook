#include <stdio.h>
int main()
{
    int i, j;
    double sum, average, score;

    // 使用 while
    i = 1;
    while (i++ <= 3)
    {
        sum = 0;
        printf("请输入第 %d 个学生3门课的成绩:\n", i - 1);
        j = 1;
        do
        {
            scanf("%lf", &score); // double 用 %lf 接收， float 用 %f 接收
            sum += score;
        } while (++j <= 3);
        average = sum / 3.0;
        printf("第 %d 名学生的平均成绩是 %f \n", i - 1, average);
    }
    return 0;

    // 使用 for
    for (i = 1; i <= 3; i++)
    {
        sum = 0;
        printf("请输入第 %d 个学生3门课的成绩:\n", i);
        for (j = 1; j <= 3; j++)
        {
            scanf("%lf", &score); // double 用 %lf 接收， float 用 %f 接收
            sum += score;
        }
        average = sum / 3.0;
        printf("第 %d 名学生的平均成绩是 %f \n", i, average);
        sum = 0;
    }
    return 0;
}