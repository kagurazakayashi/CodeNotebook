/*
有两个班级，分别有35名和30名学生，调用一个average函数，分别求这两个班的学生的平均成绩。
- 需要解决怎样用同一个函数求两个不同长度的数组的平均值的问题
- 定义average函数时不指定数组的长度，在形参表中增加一个整型变量i
- 从主函数把数组实际长度从实参传递给形参i
- 这个i用来在average函数中控制循环的次数
- 为简化，设两个班的学生数分别为5和10
*/

#include <stdio.h>

int main()
{
    double average(double score[], int amount);
    double score1[30] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, m1, m2;
    double score2[35] = {11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 1, 2, 3, 4, 5};
    m1 = average(score1, 30);
    printf("班级1平均成绩：%f\n", m1);
    m2 = average(score2, 35);
    printf("班级2平均成绩：%f\n", m2);
    return 0;
}
double average(double arr[], int amount)
{
    int i;
    double sum = 0;
    for (i = 1; i < amount; i++)
        sum += arr[i];
    return sum / amount;
}