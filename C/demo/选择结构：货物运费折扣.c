/* 运输公司对用户计算运输费用。路程(s km)越远，每吨·千米运费越低。
标准如下：
s < 250        没有折扣
250 ≤ s < 500    2 ％折扣
500 ≤ s < 1000   5 ％折扣
1000 ≤ s < 2000  8 ％折扣
2000 ≤ s < 3000  10％折扣
3000 ≤ s         15％折扣
设每吨每千米货物的基本运费为p，货物重为w，距离为s，折扣为d
总运费f的计算公式为 f = p × w × s × ( 1 - d )
*/
#include <stdio.h>
#include <math.h>
int main()
{
    int s, c;                                          // 路程距离，倍数
    double price = 100, weight = 20, discount, amount; // 单价，重量，折扣，总运费
    s = 300;
    c = s / 250;
    switch (c)
    {
    case 0:
        discount = 0;
        break;
    case 1:
        discount = 0.02; // 2% 折扣
        break;
    case 2:
    case 3:
        discount = 0.05;
        break;
    case 4:
    case 5:
    case 6:
    case 7:
        discount = 0.08;
        break;
    case 8:
    case 9:
    case 10:
    case 11:
        discount = 0.1;
        break;
    default:
        discount = 0.15; // 最大折扣了
    }
    amount = s * price * weight * (1 - discount);
    printf("The cost is %f\n",amount);
    return 0;
}