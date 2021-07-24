// 方式1，splice
var ary = [1,2,3,4];
ary.splice(0,ary.length);
console.log(ary); // 输出 []，空数组，即被清空了

// 方式2，length赋值为0
// 这种方式很有意思，其它语言如Java，其数组的length是只读的，不能被赋值，Java中会报错，编译通不过。而JS中则可以，且将数组清空了。
var ary = [1,2,3,4];
ary.length = 0;
console.log(ary); // 输出 []，空数组，即被清空了
// 目前 Prototype 中数组的 clear 和mootools库中数组的 empty 使用这种方式清空数组。  

// 方式3，赋值为[]
var ary = [1,2,3,4];
ary = []; // 赋值为一个空数组以达到清空原数组
// 这里其实并不能说是严格意义的清空数组，只是将ary重新赋值为空数组，之前的数组如果没有引用在指向它将等待垃圾回收。

// 方式2 保留了数组其它属性，方式3 则未保留。

// https://www.cnblogs.com/snandy/archive/2011/04/04/2005156.html