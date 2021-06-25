// JS sort函数（按照首字母字符排序）

// 直接调用sort的排序是按照首字母的大小来从小到大进行排列的

var myArry = ['b', 'c' ,'a']
console.log(myArry.sort())  // [ 'a', 'b', 'c' ]

var myArry = ['1', '3' ,'2']
console.log(myArry.sort())  // [ '1', '2', '3' ]

var myArry = [1, 3 ,2]
console.log(myArry.sort())   // [ 1, 2, 3 ]

// sort排序返回的值是原数组，也就是说调用sort后会改变原数组的值

// sort对数值进行排序，应该做些处理:

// 未做处理
var myArry = [-1, -4, -2, 0, 1, 2]
console.log(myArry.sort())   // [ -1, -2, -4, 0, 1, 2 ]并不是按照数值大小排序

// 从小到大返回a-b , 从大到小返回b-a
var myArry = [-1, -4, -2, 0, 1, 2]
console.log(myArry.sort(function(a,b){
    return a-b;
}))   // [ -4, -2, -1, 0, 1, 2 ]

// https://blog.csdn.net/qq_37086982/article/details/98874253