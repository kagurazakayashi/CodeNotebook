#include <stdio.h>
#include <stdlib.h> // malloc 需要
#include <string.h>
struct student // 结构体
{
    int num; // %ld
    char name[20];
    float score;
    struct student *next;
};
int main()
{
    struct student *head, *p, *p1, *p2;
    printf("Please input the information about student 1 (num,name,score):\n");

    p1 = (struct student *)malloc(sizeof(struct student)); // 开辟内存空间
    head = p1;
    p2 = p1; // p1 腾出来以后，继续申请内存空间
    scanf("%d%s%f", &p1->num, p1->name, &p1->score); // p1->name 不需要 &

    p1 = (struct student *)malloc(sizeof(struct student));
    p2->next = p1;
    p2 = p1;
    scanf("%d%s%f", &p1->num, p1->name, &p1->score);

    p1 = (struct student *)malloc(sizeof(struct student));
    p2->next = p1;
    p2 = p1;
    scanf("%d%s%f", &p1->num, p1->name, &p1->score);

    p2 = p1;
    p2->next = NULL;

    for (p = head; p !=NULL; p=p->next)
    {
        printf("ID No. %d, Name: %s, score: %f\n", p->num, p->name, p->score);
    }
    return 0;
}
/*
Please input the information about student 1 (num,name,score):
10 yashi 67
11 miyabi 89
12 moe 88
ID No. 10, Name: yashi, score: 67.000000
ID No. 11, Name: miyabi, score: 89.000000
ID No. 12, Name: moe, score: 88.000000
*/