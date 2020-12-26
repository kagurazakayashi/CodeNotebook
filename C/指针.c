#include <stdio.h>
int main()
{
    void swap(int *, int *);
    void sort(int *, int *, int *);
    int a1 = 100, b1 = 10;
    int *p1, *p2; // int 是指针变量指定的「基类型」
    p1 = &a1;     // int *p1=&a
    p2 = &b1;     // 声明的时候加 * ，赋值不加 * ，地址要赋值给地址
    printf("a1 = %d, b1 = %d\n", a1, b1);
    printf("*p1 = %d, *p2=%d\n\n", *p1, *p2);
    /*
        a = 100, b = 10
        *p1 = 100, *p2=10
    */
    int a, b, c, t;
    int *a_pointer, *b_pointer, *c_pointer;
    a_pointer = &a;
    b_pointer = &b;
    c_pointer = &b;
    printf("请输入3个整数：\n");
    scanf("%d%d%d", &a, &b, &c);
    printf("输入 a = %d, b = %d, c = %d\n", a, b, c);
    if (b > a)
    {
        // t = a;
        // a = b;
        // b = t;

        // a_pointer = &b;
        // b_pointer = &a;

        // swap(a_pointer, b_pointer);
    }
    sort(&a, &b, &c);
    printf("a = %d, b = %d, c = %d\n", a, b, c);
    // int i = 3; // 直接存取（直接送到i所标识的单元中）
    // *i = 3;    //间接存取（送到指针变量所指向的单元）
    return 0;
}

// 交换指针变量
void swap(int *pointer1, int *pointer2)
{
    printf("*pointer1 = %d, *pointer2 = %d -> ", *pointer1, *pointer2);
    int x; // 不能 int *x; x=*pointer1; ，没有确定的指向
    x = *pointer1;
    *pointer1 = *pointer2;
    *pointer2 = x;
    printf("*pointer1 = %d, *pointer2 = %d\n", *pointer1, *pointer2);
}

// 排序指针变量
void sort(int *x, int *y, int *z)
{
    if (*x < *y)
        swap(x, y);
    if (*x < *z)
        swap(x, z);
    if (*y < *z)
        swap(y, z);
}