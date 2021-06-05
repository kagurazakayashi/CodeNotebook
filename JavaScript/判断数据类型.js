/*
一、JS中数据类型
基本数据类型（Undefined、Null、Boolean、Number、String）
复杂数据类型 （Object）
*/

// 二、判断数据类型
// 下面将对如下数据进行判断它们的类型
var bool = true
var num = 1
var str = 'abc'
var und = undefined
var nul = null
var arr = [1, 2, 3]
var obj = { name: 'haoxl', age: 18 }
var fun = function () { console.log('I am a function') }

// 1.使用 typeof // 是哪种类型
console.log(typeof bool); // boolean
console.log(typeof num);  // number
console.log(typeof str);  // string
console.log(typeof und);  // undefined
console.log(typeof nul);  // object
console.log(typeof arr);  // object
console.log(typeof obj);  // object
console.log(typeof fun);  // function
console.log(typeof xxx);  // undefined

// 2.使用 instanceof // 是不是某种类型
console.log(bool instanceof Boolean); // false
console.log(num instanceof Number);   // false
console.log(str instanceof String);   // false
console.log(und instanceof Object);   // false
console.log(arr instanceof Array);    // true
console.log(nul instanceof Object);   // false
console.log(obj instanceof Object);   // true
console.log(fun instanceof Function); // true

var bool2 = new Boolean()
console.log(bool2 instanceof Boolean); // true

var num2 = new Number()
console.log(num2 instanceof Number);   // true

var str2 = new String()
console.log(str2 instanceof String);   // true

function Person() { }
var per = new Person()
console.log(per instanceof Person);    // true

function Student() { }
Student.prototype = new Person()
var haoxl = new Student()
console.log(haoxl instanceof Student); // true
console.log(haoxl instanceof Person);  // true