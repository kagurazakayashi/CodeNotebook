/*
自增、自减运算符：
- 作用是使变量的值１或减１
    - ++i，--i：在使用i之前，先使i的值加（减）1
    - i++，i--：在使用i之后，使i的值加（减）1
*/
#include<stdio.h>
int main()
{
    int a = 5;
    printf("a = %d\n",a++); // 先使用了 a 的值，然后++ // 5
    printf("a = %d\n",++a); // 先++，再使用了 a 的值   // 7
    return 0;
}