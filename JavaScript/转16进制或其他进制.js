// JS进制转换

// 16 进制 转 10 进制
parseInt('ff', 16); // 255
// 10 进制 转 16 进制
(255).toString(16); // ff
(1).toString(16) // 1 所以特别地，注意转换为两位数

// NodeJs中有Buffer对象，在socket传输中比较常见。
// Buffer转成十六进制
let b = Buffer.from([1,2,3,4]) // <Buffer 01 02 03 04>
b.toString('hex') // '01020304' 再根据需要两两加空格及0x

// https://blog.csdn.net/alwxkxk/article/details/78332270