// 声明一个区间数组

// 一个闭区间数组，其中包含的数值为 1-100。 .. 表示闭区间
var nums1:IntRange = 1..100
// 前闭后开区间，取值 1-99. util 表示前闭后开区间
var nums2:IntRange = 1 util 100

// for 基本循环格式
for(num in nums1){
    //DO STH
}

// 带有步进的for循环。所谓步进，就是递增幅度。默认步进为1
for (num in nums1 step 10) {
    //DO STH
}