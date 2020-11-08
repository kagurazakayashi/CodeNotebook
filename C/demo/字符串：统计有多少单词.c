/*
输入一行字符，统计其中有多少个单词，单词之间用空格分隔开。
思路：问题的关键是怎样确定“出现一个新单词了”
- 从第1个字符开始逐个字符进行检查，判断此字符是否是新单词的开头，如果是，就使变量num的值加1，最后得到的num的值就是单词总数
- 判断是否出现新单词，可以由是否有空格出现来决定(连续的若干个空格作为出现一次空格；一行开头的空格不统计在内)
- 如果测出某一个字符为非空格，而它的前面的字符是空格，则表示“新的单词开始了”，此时使num累加1
- 如果当前字符为非空格而其前面的字符也是非空格，则num不应再累加1
- 用变量word作为判别当前是否开始了一个新单词的标志，若word=0表示未出现新单词，如出现了新单词，就把word置成1
- 前面一个字符是否空格可以从word的值看出来，若word等于0，则表示前一个字符是空格；如果word等于1，意味着前一个字符为非空格
*/
#include <stdio.h>
#include <string.h>
int main()
{
    char str[] = "I am a student.";
    int len, word, num;
    char c;
    word = 0;
    num = 0;
    len = strlen(str);
    for (int i = 0; i < len; i++)
    {
        c = str[i];
        if (c == ' ')
        {
            if (word == 1)
                word = 0;
        }
        else if (word == 0)
        {
            word = 1;
            num++;
        }
    }
    printf("num = %d\n", num);
    return 0;
}