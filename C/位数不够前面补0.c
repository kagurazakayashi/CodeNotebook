#include <stdio.h>
int main()
{
    // 将输出的前面补上0，直到占满指定列宽为止
    int a = 4;
    printf("%02d", a); // 输出：04
    // 也可以用 * 代替位数，在后面的参数列表中用变量控制输出位数
    int b = 4;
    int n = 3;
    printf("%0*d", n, b); // 输出：004
    return 0;
}