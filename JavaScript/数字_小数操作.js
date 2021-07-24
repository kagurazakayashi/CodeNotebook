// 向下取整
// Math.floor() 不进行四舍五入，直接舍去小数部分
console.log(Math.floor(12.10345)); //结果 12
console.log(Math.floor(12.9801)); //结果 12

// 向上取整
// Math.ceil() 只要有小数且小数不为 0 ，取整都直接给个位+1，小数位都舍去
console.log(Math.ceil(12.10345)); //结果 13
console.log(Math.ceil(12.9801)); //结果 13
console.log(Math.ceil(12)); //结果 12
console.log(Math.ceil(12.0)); //结果 12

// 四舍五入
// Math.round() 小数第一位小于 5 舍去，大于等于5向前进位
console.log(Math.round(12.40345)); //结果 12
console.log(Math.round(12.5801)); //结果 13

// 保留小数位数
// toFixed(n) n为要保留的小数位数，toFixed() 会做四舍五入处理
console.log((12.40345).toFixed(2)); //结果 12.40
console.log((12.40645).toFixed(2)); //结果 12.41

// 科学计数法
// toPrecision(1) n为要保留的位数，toPrecision() 会做四舍五入处理
console.log((12567.40345).toPrecision(1)); //结果 1e+4;
console.log((12567.40645).toFixed(2)); //结果 1.3e+4

// 去掉小数部分多余的 0
// parseFloat() 把小数多余的 0 去掉
console.log(parseFloat(12.10345000000000000)); //结果 12.10345