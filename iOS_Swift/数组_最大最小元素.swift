/*
Find minimum (or maximum) in a List
We have various ways to find the minimum and maximum of a sequence, among those the min and max functions:

找到数组中最小（或最大）的元素
我们有多种方式求出 sequence 中的最大和最小值，其中一种方式是使用 minElement 和 maxElement 函数：
*/

// 最小 Find the minimum of an array of Ints 
[10,-22,753,55,137,-1,-279,1034,77].sorted().first 
[10,-22,753,55,137,-1,-279,1034,77].reduce(Int.max, min) 
[10,-22,753,55,137,-1,-279,1034,77].min() 

// 最大 Find the maximum of an array of Ints 
[10,-22,753,55,137,-1,-279,1034,77].sorted().last 
[10,-22,753,55,137,-1,-279,1034,77].reduce(Int.min, max) 
[10,-22,753,55,137,-1,-279,1034,77].max()

// https://swift.gg/2016/04/18/10-Swift-One-Liners-To-Impress-Your-Friends/