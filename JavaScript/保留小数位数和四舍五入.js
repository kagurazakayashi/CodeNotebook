// toFixed() 方法可把 Number 四舍五入为指定小数位数的数字。
var num = new Number(13.37);
num.toFixed(1); // 13.4
// 保留两位小数
num.toFixed(2);

// round() 方法可把一个数字舍入为最接近的整数。
Math.round(0.60);  // 1
Math.round(0.50);  // 1
Math.round(0.49);  // 0
Math.round(-4.40); // -4
Math.round(-4.60); // -5

// 向上取整：ceil 是`天花板`的意思，表示在一个数值之上，且距离该数最近的整数。
Math.ceil(12.34); // 13
Math.ceil(12.68); // 13

// 向下取整：floor 是`地板`的意思，表示在一个数值之下，且距离该数最近的整数。
Math.floor(12.34); // 12
Math.floor(12.68); // 12
// 容易出现精度问题
