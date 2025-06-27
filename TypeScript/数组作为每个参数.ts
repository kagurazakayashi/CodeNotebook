// 数组作为每个参数

// 使用 JavaScript/TypeScript 的 扩展运算符（spread operator） 来将数组作为参数传入
const timeArray: [number, number, number, number] = [23, 59, 59, 999];
const date = new Date();
date.setHours(...timeArray);  // 相当于 setHours(23, 59, 59, 999)
