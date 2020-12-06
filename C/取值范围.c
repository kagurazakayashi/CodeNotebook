#include <stdio.h>
#include <limits.h>
#include <float.h>
int main(void)
{
printf("char的位数:\t%u\n",CHAR_BIT);
printf("char类型的最大值:\t%d\n",CHAR_MAX);
printf("char类型的最小值:\t%d\n",CHAR_MIN);
printf("signed char类型的最大值:\t%d\n",SCHAR_MAX);
printf("signed char类型的最小值:\t%d\n",SCHAR_MIN);
printf("unsigned char类型的最大值:\t%u\n",UCHAR_MAX);
printf("\n");
printf("short类型的最大值:\t%d\n",SHRT_MAX);
printf("short类型的最小值:\t%d\n",SHRT_MIN);
printf("unsigned short类型的最大值:\t%u\n",USHRT_MAX);
printf("\n");
printf("int类型的最大值:\t%d\n",INT_MAX);
printf("int类型的最小值:\t%d\n",INT_MIN);
printf("unsigned int类型的最大值:\t%u\n",UINT_MAX);
printf("\n");
printf("long类型的最大值:\t%ld\n",LONG_MAX);
printf("long类型的最小值:\t%ld\n",LONG_MIN);
printf("unsigned long类型的最大值:\t%lu\n",ULONG_MAX);
printf("\n");
printf("long long类型的最大值:\t%lld\n",LLONG_MAX);
printf("long long类型的最小值:\t%lld\n",LLONG_MIN);
printf("unsigned long long类型的最大值:\t%llu\n",ULLONG_MAX);
printf("\n");
printf("float类型的尾数位数:\t%u\n",FLT_MANT_DIG);
printf("float类型的最小有效数字位数:\t%u\n",FLT_DIG);
printf("带有全部有效数字位数的float类型的负指数的最小值:\t%d\n",FLT_MAX_10_EXP);
printf("带有全部有效数字位数的float类型的正指数的最大值:\t%d\n",FLT_MIN_10_EXP);
printf("保留全部精度的float类型正数的最小值:\t%e\n",FLT_MIN);
printf("保留全部精度的float类型正数的最大值:\t%e\n",FLT_MAX);
printf("1.00和比1.00大的最小的float类型值之间的差值:\t%e\n",FLT_EPSILON);
printf("\n");
printf("double类型的尾数位数:\t%u\n",DBL_MANT_DIG);
printf("double类型的最小有效数字位数:\t%u\n",DBL_DIG);
printf("带有全部有效数字位数的double类型的负指数的最小值:\t%u\n",DBL_MAX_10_EXP);
printf("带有全部有效数字位数的double类型的正指数的最大值:\t%d\n",DBL_MIN_10_EXP);
printf("保留全部精度的double类型正数的最小值:\t%e\n",DBL_MIN);
printf("保留全部精度的double类型正数的最小值:\t%e\n",DBL_MAX);
printf("1.00和比1.00大的最小的double类型值之间的差值:\t%e\n",DBL_EPSILON);
printf("\n");
printf("long double类型的尾数位数:\t%d\n",LDBL_MANT_DIG);
printf("long double类型的最小有效数字位数:\t%d\n",LDBL_DIG);
printf("带有全部有效数字位数的long double类型的负指数的最大值:\t%d\n",LDBL_MAX_10_EXP);
printf("带有全部有效数字位数的long double类型的正指数的最小值:\t%d\n",LDBL_MIN_10_EXP);
printf("保留全部精度的long double类型正数的最小值:\t%Le\n",LDBL_MIN);
printf("保留全部精度的long double类型正数的最大值:\t%Le\n",LDBL_MAX);
printf("1.00和比1.00大的最小的long double类型值之间的差值:\t%Le\n",LDBL_EPSILON);
return 0;
}