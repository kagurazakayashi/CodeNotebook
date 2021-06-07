var str = "1234567890ABCD";

// 从第 5 个字符开始截取到末尾
document.write(str.substring(4)); // 567890ABCD
// 从第 5 个字符开始截取到第10个字符
document.write(str.substring(4, 10)); // 567890

// 从第 4 个字符开始截取6个字符
document.write(str.substr(4, 6)); // 567890

// 从第 5 个字符开始截取到末尾
document.write(str.slice(4)); // 567890ABCD
// 从第 5 个字符开始截取到第10个字符
document.write(str.slice(4, 10)); // 567890

// https://www.runoob.com/w3cnote/js-extract-string.html

// 取第一个字符
str.substring(0, 1);
// 取最后一个字符
str.substring(str.length - 1);