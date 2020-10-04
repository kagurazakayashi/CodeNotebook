/*
条件表达式：三目运算符示例
表达式１ ? 表达式２ : 表达式３
? : 条件运算符
条件运算符优先于赋值运算符
条件运算符的结合方向为“自右至左”
*/
int main()
{
    int a, b, max;
    if (a > b)
        max = a;
    else
        max = b;
    max = (a > b) ? a : b;
    return 0;
}
/*
以下为合法的使用方法
a > b ? (max=a) : (max=b);
a > b ? printf("%d",a) : printf("%d",b);
*/