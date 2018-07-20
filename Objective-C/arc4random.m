// 1)、arc4random() 比较精确不需要生成随即种子

//        使用方法 ：

//                  通过arc4random() 获取0到x-1之间的整数的代码如下：

                 int value = arc4random() % x; 


                //  获取1到x之间的整数的代码如下:

                 int value = (arc4random() % x) + 1; 

 

    //    2)、CCRANDOM_0_1() cocos2d中使用 ，范围是[0,1]

    //    使用方法：

                 float random = CCRANDOM_0_1() * 5; //[0,5]   CCRANDOM_0_1() 取值范围是[0,1]

 

    //    3)、random() 需要初始化时设置种子

    //   使用方法：

                srandom((unsigned int)time(time_t *)NULL); //初始化时，设置下种子就好了。
