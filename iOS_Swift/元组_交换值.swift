// Swift 的元组可以被用来交换两个变量的值
// you can leverage tuple destructuring to perform a compact variable swap:

var a=1,b=2

(a,b) = (b,a)
a //2
b //1

// https://swift.gg/2016/04/18/10-Swift-One-Liners-To-Impress-Your-Friends/