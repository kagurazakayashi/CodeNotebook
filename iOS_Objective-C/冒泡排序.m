
/*
        {8,2,7,5} 冒泡排序
        1. 8275 3
        2. 2758 2
        3. 2578 1
        */
       printf("\n\n======== 数组内冒泡排序大小 ========\n");
       for (int i = 0; i < 7; i++){ //i=外层循环：运算几次？
           printf("----外层第%d次循环----\n",i);
           for (int j = 0; j < 7-i-1; j++) { //j=内层循环：排一次7位序 -i是少比较一位
               printf("交换前："); for (int i = 0; i < 7; i++) { printf("%d ",num[i]); }//交换前状态显示用
               if (num[j] > num[j+1]) { //如果第j位中的数大于下一位中的数
                   int temp = num[j]; //把当前位存到临时
                   num[j] = num[j+1]; //本位中的数=下一位中的数
                   num[j+1] = temp; //下一位=临时 前后交换完成
               }
               printf("\n交换后："); for (int i = 0; i < 7; i++) { printf("%d ",num[i]); }//交换后状态显示用
               printf("\n^内层第%d次循环，比较第%d-%d位完成。当前最大值：%d。\n",j+1,j+1,j+2,num[i]);
           }
           
       }
       printf("数组内冒泡排序大小最终结果：");
       for (int i = 0; i < 7; i++) 
       {
           printf("%d, ",num[i]);
       }
void soryArray(int *a, int len);
void soryArray(int *a, int len)
{
   for (int i = 0; i < len ; i++)
   {
       for (int j = 0; j < len - 1 - i; j++)
       {
           if (*(a+j) > *((a+1)+j))
           {
               int temp = 0;
               temp = *(a+j);
               *(a+j) = *((a+1)+j);
               *((a+1)+j) = temp;
           }
       }
   }
}
 
