//
//  main.swift
//  swift数组
//
//  Created by zhangbiao on 14-6-15.
//  Copyright (c) 2014年 理想. All rights reserved.
//

import Foundation

println("数组")

/*
Swift 语言中的数组用来按顺序存储相同类型的数据
*/


//1.定义数组
var numarr:Int[] = [1,3,5,7,9];
var strarr:String[] = ["理想","swift"];



//2.访问和修改数租
//(1)数组长度  和 访问数组中的某个元素
println("strarr 数租的长度为:\(strarr.count) 数组的 第1个值为:\(strarr[0])");
//(2)向数组中追加元素
strarr.append("ios");
//运行结果:[理想, swift, ios]




//(3)使用加法赋值运算符（+=）也可以直接在数组后面添加元素
strarr+="android";
//运行结果:[理想, swift, ios, android]





//(4)直接向数组最后添加一个数组
strarr+=["AAA","BBB","CCC"];
//运行结果:[理想, swift, ios, android, AAA, BBB, CCC]




//(5)使用Index 向数组中插入元素
strarr.insert("000",atIndex:2);
//运行结果:[理想, swift, 000, ios, android, AAA, BBB, CCC]




//(6)使用removeAtIndex 删除某个数组元素  注意 removeAtIndex() 是有返回值的，返回的就是删除的元素
strarr.removeAtIndex(2);
//运行结果:[理想, swift, ios, android, AAA, BBB, CCC]




//(7)删除数组的最后一个元素
strarr.removeLast();
//运行结果:[理想, swift, ios, android, AAA, BBB]




//(8)使用enumerate函数来遍历数租 返回值是一个元组
for bgen in enumerate(strarr)
{
    println("元素下标:\(bgen.0)  元素值:\(bgen.1)");
}
//运行结果:
/*
元素下标:0  元素值:理想
元素下标:1  元素值:swift
元素下标:2  元素值:ios
元素下标:3  元素值:android
元素下标:4  元素值:AAA
元素下标:5  元素值:BBB
*/






//(9)使用构造语法来创建数组
//创建一个Int数据类型构成的空数组：
var nums=Int[]();
//创建一个自定义数据类型构成的空数组：
class Student  // 创建一个类 ,后面会具体说，这里就是为了得到这个类的类型
{
    //数据成员和成员函数略
    
}
var students = Student[]();  // students 是一个Student 类型的数组




//(10)创建特定大小并且所有数据都被默认值得数组
var  nums2 = Int[](count: 5, repeatedValue:3);  // 有5 个元素  元素的值都是 3
println(nums2);
//运行结果:[3, 3, 3, 3, 3]





//(10)数组的赋值和拷贝行为
/*
特点：数组的拷贝行为只有在必要时才会发生

将一个数组(Array)实例赋给一个变量或常量，或者将其作为参数传递给函数或方法调用，在事件发生时数组的内容不会被拷贝。当你在一个数组内修改某一元素，修改结果也会在另一数组显示。

数组的拷贝行为仅仅当操作有可能修改数组长度时才会发生

解决数组拷贝问题: 确保数组的唯一性

*/

var testarr1:Int[]=[1,2,3,4,5];
var testarr2=testarr1;
println(" testarr1:\(testarr1)\n testarr2:\(testarr2)");
//执行结果
/*
testarr1:[1, 2, 3, 4, 5]
testarr2:[1, 2, 3, 4, 5]
*/

testarr1[1]=1000;//改变testarr1 中第二个（下标为1）的元素的值为 1000 ,**注意:根据数组的拷贝机制 testarr2也会该改变
println(" testarr1:\(testarr1)\n testarr2:\(testarr2)");
//执行结果
/*
testarr1:[1, 1000, 3, 4, 5]
testarr2:[1, 1000, 3, 4, 5]
*/

testarr2.removeLast();//删除数组的最后一个元素，改变数组长度，数组发生拷贝行为
println(" testarr1:\(testarr1)\n testarr2:\(testarr2)");
testarr1[1]=2;//改变testarr1 中第二个（下标为1）的元素的值为 1000 ,**注意:根据数组的拷贝机制testarr2中的元素不在会改变，以为在在数组长度改变时，已经发生了数组的拷贝行为
println(" testarr1:\(testarr1)\n testarr2:\(testarr2)");
//执行结果：
/*
testarr1:[1, 2, 3, 4, 5]
testarr2:[1, 1000, 3, 4]
*/



//解决数组拷贝问题: 确保数组的唯一性
/*
在操作一个数组，或将其传递给函数以及方法调用之前是很有必要先确定这个数组是有一个唯一拷贝的。通过在数组变量上调用unshare方法来确定数组引用的唯一性。(当数组赋给常量时，不能调用unshare方法)
如果一个数组被多个变量引用，在其中的一个变量上调用unshare方法，则会拷贝此数组，此时这个变量将会有属于它自己的独立数组拷贝。当数组仅被一个变量引用时，则不会有拷贝发生


*/

var testarr4:Int[]=[1,2,3,4,5];
var testarr5=testarr4;
var testarr6=testarr5;
testarr5.unshare(); //调用 unshare方法，则会拷贝此数组，此时 testarr5 将会有属于它自己的独立数组拷贝
testarr5[2]=0;
println("testarr4: \(testarr4)\n testarr5:\(testarr5) \n testarr6:\(testarr6)");
//执行结果:
/*
testarr4: [1, 2, 3, 4, 5]
testarr5:[1, 2, 0, 4, 5]
testarr6:[1, 2, 3, 4, 5]
*/


//强制复制数组
/*我们通过调用数组的copy方法进行强制显性复制。这个方法对数组进行了浅拷贝(shallow copy),并且返回一个包含此拷贝的新数组。
*/


var names = ["Mohsen", "Hilary", "Justyn", "Amy", "Rich", "Graham", "Vic"]
var copiedNames = names.copy();
copiedNames[0] = "Mo"
println(names[0]);
// 执行结果： Mohsen


//说明：如果你仅需要确保你对数组的引用是唯一引用，请调用unshare方法，而不是copy方法。unshare方法仅会在确有必要时才会创建数组拷贝。copy方法会在任何时候都创建一个新的拷贝，即使引用已经是唯一引用。
