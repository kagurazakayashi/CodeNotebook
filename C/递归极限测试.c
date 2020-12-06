#include <stdio.h>
void Main(unsigned long long t);
int main()
{
    Main(0);
}
void Main(unsigned long long t)
{
    printf("第%llu次递归\n", t);
    Main(++t);
}