// 数字枚举
enum Enumeration1 { //1,2,3
    Aaa = 1,
    Bbb,
    Ccc
}
enum Enumeration2 { //0,1,2
    Aaa,
    Bbb,
    Ccc
}
// 字符串枚举
enum Enumeration3 {
    Aaa='aa',
    Bbb='bb',
    Ccc='cc'
}

// 反响映射：既可以从属性名获取值，也可以从值获取属性名：
console.log(Enumeration2.Aaa); // 0
console.log(Enumeration2[0]);  // Aaa
// 字符串枚举不支持