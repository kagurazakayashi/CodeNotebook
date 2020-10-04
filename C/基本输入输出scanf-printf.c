#include <stdio.h>
#include <math.h>
int main()
{
    /*
    用printf函数输出数据
        在C程序中用来实现输出和输入的，主要是printf函数和scanf函数
        这两个函数是格式输入输出函数
        用这两个函数时，必须指定格式
        printf函数的一般格式:printf（格式控制，输出表列）
    */
    /*
    常用格式字符：
    ｄ格式符。用来输出一个有符号的十进制整数
        可以在格式声明中指定输出数据的域宽 printf(”%5d%5d\n”,12,-345);
        %d输出int型数据
        %ld输出long型数据
    ｃ格式符。用来输出一个字符
        char ch=’a’;
        printf(”%c”,ch);   或
        printf(”%5c”,ch);
        输出字符：a
        printf（”%s”,”CHINA”）;
        输出字符串：CHINA
    f格式符。用来输出实数，以小数形式输出
        1. 不指定数据宽度和小数位数，用%f
        用%f输出实数，只能得到６位小数。
        2. 指定数据宽度和小数位数。用%m.nf
        3. 输出的数据向左对齐，用%-m.nf
        - float型数据只能保证6位有效数字
        - double型数据能保证15位有效数字
        - 计算机输出的数字不都是绝对精确有效的
    e格式符。指定以指数形式输出实数
        %e，VC++给出小数位数为６位
        指数部分占5列
        小数点前必须有而且只有1位非零数字
    */

    printf("%.0f\n", 10000 / 3.0);
    // 20.15 : 小数点前 20 位（不够补空格）， 小数点后 15 位（不够补0）
    printf("2/3=%20.15f\n", 2 / 3);
    printf("2.0/3=%lf\n", 2.0 / 3);

    /*
    scanf 函数的一般形式:
        scanf（格式控制，地址表列）
    scanf函数中的格式声明:
        与printf函数中的格式声明相似
        以％开始，以一个格式字符结束，中间可以插入附加的字符
        scanf("a=%f,b=%f,c=%f",&a,&b,&c);
    */

    float x, y, z;
    printf("Please input x,y,z\n");
    // 不能直接输入 x y z ，要按规定好的格式输入 x=1,y=1,z=1
    scanf("x=%f,y=%f,z=%f", &x, &y, &z);
    // 这种方式加空格即可：
    scanf("%f%f%f", &x, &y, &z);
    printf("x=%f, y=%f, z=%f", x, y, z);

    char c1, c2, c3;
    // 字符不可用空格方式输入（空格也是字符）
    scanf("%c%c%c", &c1, &c2, &c3);
    // DEMO: 1234a123o.26
    printf("c1=%c, c2=%c, c3=%c", c1, c2, c3); // c1=1, c2=2, c3=3

    /*
    用putchar函数输出一个字符
        从计算机向显示器输出一个字符
        putchar函数的一般形式为： putchar(c)
    */
    putchar('K');
    putchar('Y');
    putchar('S');
    // char a,b,c;
    // a='K';b='Y';c='S';
    // KYS
    int a = 66, b = 79, c = 89;
    putchar(a); // 输出 ASCII 对应字符
    putchar(b);
    putchar(c);
    // BOY
    putchar('\101'); // A
    putchar('\'');   // '

    /*
    用getchar函数输入一个字符
        向计算机输入一个字符
        getchar函数的一般形式为： getchar()
    */
    char a, b, c;
    a = getchar(); // 获取字符
    b = getchar();
    c = getchar();
    putchar(a); // 原样输出
    putchar(b);
    putchar(c);
    putchar(getchar()); // 获取字符+原样输出

    char c1, c2;
    c1 = 97;
    c2 = 98;
    printf("c1=%c,c2=%c\n", c1, c2); // c1=a,c2=b
    printf("c1=%d,c2=%d\n", c1, c2); // c1=97,c2=98
    c1 = 197;
    c2 = 198;
    printf("c1=%c,c2=%c\n", c1, c2); // c1=?c2=?
    printf("c1=%d,c2=%d\n", c1, c2); // c1=-59,c2=-58 // char -128~127 数据溢出

    unsigned char c1, c2; // 无符号
    c1 = 197;
    c2 = 198;
    printf("c1=%c,c2=%c\n", c1, c2); // c1=?c2=?
    printf("c1=%d,c2=%d\n", c1, c2); // c1=197,c2=198

    int a, b;
    float x, y;
    char c1, c2;
    scanf("a=%d b=%d", &a, &b); // a=3 b=7
    scanf("%f %e", &x, &y);     // 8.5 7.182e001 后面直接跟下行输入 Aa ，否则换行符会被赋值进去
    scanf("%c%c", &c1, &c2);    // Aa
    printf("a=%d,b=%d,x=%f,y=%f,c1=%c,c2=%c\n", a, b, x, y, c1, c2);
    // a=3 b=7\n8.5 7.182e001\nAa :
    // a=3,b=7,x=8.500000,y=71.820000,c1=\n,c2=A c1
    // a=3 b=7\n8.5 7.182e001Aa :
    // a=3,b=7,x=8.500000,y=71.820000,c1=A,c2=a

    // e
    printf("%e", 123.456);     // 1.234560 e+002
    printf("%13.2e", 123.456); //     1.23e+002 (前面有4个空格)

    return 0;
}
