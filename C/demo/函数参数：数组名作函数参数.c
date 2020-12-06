/*
有一个一维数组score，内放10个学生成绩，求平均成绩。
解题思路：
- 用函数average求平均成绩，用数组名作为函数实参，形参也用数组名
- 在average函数中引用各数组元素，求平均成绩并返回main函数
*/
#include <stdio.h>

int main()
{
    double average(double score[10]);
    double score[10], m;
    int i;
    printf("请输入10个学生成绩：\n");
    for (i = 0; i < 10; i++)
        scanf("%lf", &score[i]);
    m = average(score);
    printf("10名学生平均成绩：%f\n", m);
    return 0;
}

double average(double arr[10])
{
    int i;
    double sum = 0;
    for (i = 0; i < 10; i++)
    {
        sum += arr[i];
    }
    return sum / 10;
}

/*
请输入10个学生成绩：
1 2 3 4 5 6 7 8 9 10
10名学生平均成绩：5.500000
*/