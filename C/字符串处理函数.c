// 字符串处理函数
#include <stdio.h>
// 使用字符串函数时,在程序开头用#include <string.h>
#include <string.h>
int main()
{
    /*
    gets 函数
    输入字符串的函数
    作用是输入一个字符串到字符数组
    */
    char str1[5], str2[5], str3[5];
    printf("请输入3个字符串：\n");
    gets(str1);
    gets(str2);
    gets(str3);
    printf("%s\n", str1);
    printf("%s\n", str2);
    printf("%s\n", str3);
    printf("\n");

    /*
    puts 函数
    输出字符串的函数
    其一般形式为：
       puts (字符数组)
    作用是将一个字符串输出到终端
    */
    char str[20] = "China";
    puts(str);
    printf("\n");

    /*
    strcat 函数
    其一般形式为：
    strcat(字符数组1，字符数组2)
    其作用是把两个字符串连接起来，把字符串2接到字符串1的后面，结果放在字符数组1中
    */
    puts(strcat(str1, str2));
    printf("\n");

    /*
    strcpy 和 strncpy 函数
    strcpy一般形式为：
    strcpy(字符数组1,字符串2)
    作用是将字符串2复制到字符数组1中去
    */
    char str1[10], str2[] = "China";
    //        ^^要足够大
    //strcpy(数组名形式,数组名或字符串常量);
    strcpy(str1, str2);
    puts(str1);
    // str1: C h i n a \0 \0 \0 \0 \0
    // 相当于
    // strcpy(str1, "China");
    // 错误示例：
    // str1 = "China"; //错误
    // str1 = str2;    //错误
    printf("\n");

    // 可以用strncpy函数将字符串2中前面n个字符复制到字符数组1中去
    strncpy(str1, str2, 2);
    // 作用是将str2中最前面2个字符复制到str1中，取代str1中原有的最前面2个字符
    // 复制的字符个数n不应多于str1中原有的字符
    puts(str1);
    printf("\n");

    /*
    strcmp 函数
    字符串比较函数
    其一般形式为
    strcmp(字符串1,字符串2)
    作用是比较字符串1和字符串2
    */
    strcmp(str1, str2);
    strcmp("China", "Korea");
    strcmp(str1, "Beijing");
    /* 字符串比较的规则是：将两个字符串自左至右逐个字符相比，直到出现不同的字符或遇到'\0'为止
    如全部字符相同，认为两个字符串相等
    若出现不相同的字符，则以第一对不相同的字符的比较结果为准
           "A" < "B"
           "a" > "A"
    "computer" > "compare"
       "these" > "that"
          "1A" > "$20"
       "CHINA" > "CANADA"
         "DOG" < "cat"
    "Tsinghua" > "TSINGHUA"
    比较的结果由函数值带回
    - 如果字符串1=字符串2，则函数值为0
    - 如果字符串1>字符串2，则函数值为一个正整数
    - 如果字符串1<字符串2，则函数值为一个负整数
    */
    // 错误：
    if (str1 > str2)
        printf("yes");
    // 正确：
    if (strcmp(str1, str2) > 0)
        printf("yes");
    printf("\n");

    /*
    strlen 函数
    测字符串长度的函数
    其一般形式为：
        strlen (字符数组)
    它是测试字符串长度的函数
    函数的值为字符串中的实际长度
    */
    char str[10] = "China";
    printf("%d", strlen(str)); // 输出结果是5
    // 也可以直接测试字符串常量的长度
    strlen("China");
    printf("\n");

    /*
    strlwr 函数
    转换为小写的函数
    其一般形式为
       strlwr (字符串)
    函数的作用是将字符串中大写字母换成小写字母

    strupr 函数
    转换为大写的函数
    其一般形式为
       strupr (字符串)
    函数的作用是将字符串中小写字母换成大写字母
    */

    return 0;
}