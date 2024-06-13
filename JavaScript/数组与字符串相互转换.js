// 一、数组转字符串
// 需要将数组元素用某个字符连接成字符串
const arr = new Array(a, b, c, d, e);
const joina = arr.join('-'); //a-b-c-d-e  使用-拼接数组元素
const joinb = arr.join(''); //abcde

// 二、字符串转数组
// 实现方法为将字符串按某个字符切割成若干个字符串，并以数组形式返回
const str = 'ab+c+de';
const splita = str.split('+'); // [ab, c, de]
const splitb = str.split(''); //[a, b, +, c, +, d, e]
