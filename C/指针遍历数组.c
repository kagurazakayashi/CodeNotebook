// 通过指针引用数组元素
// 有一个整型数组有10个元素，输出数组的全部元素
#include <stdio.h>
int main()
{
    int arr[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 0};
    int *pa;
    pa = arr;
    int i;
    // 1. 下标法：
    for (i = 0; i < 10; i++)
        printf("%d ", arr[i]); // = pa[i]
    printf("\n");
    // 2. 通过数组名计算数组元素地址，找出元素的值：
    for (i = 0; i < 10; i++)
        printf("%d ", *(arr + i));
    printf("\n");
    // 3. 用指针变量指向数组元素：
    for (pa = arr; pa < arr + 10; pa++)
        printf("%d ", *pa);
    return 0;
}