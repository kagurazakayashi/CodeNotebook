/*
单向链表
链表中最简单的一种是单向链表，它包含两个域，一个信息域和一个指针域。这个链接指向列表中的下一个节点，而最后一个节点则指向一个空值。
一个单向链表包含两个值: 当前节点的值和一个指向下一个节点的链接
*/
#include <stdio.h>
#include <string.h>
struct student // 结构体
{
    long num; // %ld
    char name[20];
    float score;
    struct student *next;
};
int main()
{
    struct student s1, s2, s3, s4, s5;
    struct student *head, *p;
    s1.num = 10;
    s2.num = 11;
    s3.num = 12;
    s4.num = 13;
    s5.num = 14;
    strcpy(s1.name, "yashi"); // 字符串不可以 s1.name = "yashi"
    strcpy(s2.name, "miyabi");
    strcpy(s3.name, "yukari");
    strcpy(s4.name, "aya");
    strcpy(s5.name, "wenli");
    s1.score = 90;
    s2.score = 91;
    s3.score = 92;
    s4.score = 93;
    s5.score = 94;
    head = &s1;
    s1.next = &s2;
    s2.next = &s3;
    s3.next = &s4;
    s4.next = &s5;
    s5.next = NULL;
    for (p = head; p != NULL; p = p->next)
    {
        printf("ID No. %ld, Name: %s, score: %f\n", p->num, p->name, p->score);
    }
    return 0;
}
/*
ID No. 10, Name: yashi, score: 90.000000
ID No. 11, Name: miyabi, score: 91.000000
ID No. 12, Name: yukari, score: 92.000000
ID No. 13, Name: aya, score: 93.000000
ID No. 14, Name: wenli, score: 94.000000
*/