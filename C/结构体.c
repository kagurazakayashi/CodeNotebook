#include <stdio.h>
#include <string.h>
struct student // 结构体
{
    long num; // %ld
    char name[20];
    float score;
};
int main()
{
    struct student stu1, stu2; // 普通方式
    struct student *p1, *p2;   // 指针方式
    p2 = &stu2;
    stu1.num = 1001;  // 普通方式
    (*p2).num = 1002; // 指针方式
    strcpy(stu1.name, "yashi"); // 字符串不可以 stu1.name = "yashi"
    strcpy((*p2).name, "miyabi");
    stu1.score = 90;
    (*p2).score = 80;
    // 普通方式 输出
    printf("The properties of the first student:\n");
    printf("ID number: %ld, name: %s, score: %f\n", stu1.num, stu1.name, stu1.score);
    // 指针方式 输出
    printf("The properties of the second student:\n");
    printf("ID number: %ld, name: %s, score: %f\n", p2->num, p2->name, p2->score);
    return 0;
}