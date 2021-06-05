// Javascript 获取当前时间戳（毫秒级别）：

// 第一种方法 精确到秒：
var timestamp1 = Date.parse(new Date());
// 1621825842000

// 第二种方法 精确到毫秒：
var timestamp2 = (new Date()).valueOf();
// 1621825865591

// 第三种方法 精确到毫秒：
var timestamp3 = new Date().getTime();
// 1621825889432

// ES5添加的方法
Date.now();

// 获取指定时间的时间戳：
new Date("2016-08-03 00:00:00");
// Wed Aug 03 2016 00:00:00 GMT+0800 (中国标准时间)
// 这种方法在某些浏览器下不兼容，会返回NaN

// 时间戳转化成时间：
function timetrans(timestamp) {
    var date = new Date(timestamp * 1000); // 如果 timestamp 为 13 位不需要乘 1000
    var Y = date.getFullYear() + '-';
    var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
    var D = (date.getDate() < 10 ? '0' + (date.getDate()) : date.getDate()) + ' ';
    var h = (date.getHours() < 10 ? '0' + date.getHours() : date.getHours()) + ':';
    var m = (date.getMinutes() < 10 ? '0' + date.getMinutes() : date.getMinutes()) + ':';
    var s = (date.getSeconds() < 10 ? '0' + date.getSeconds() : date.getSeconds());
    return Y + M + D + h + m + s;
}
// timestamp: 1621825889
// return: "2021-05-24 11:11:29"

// https://segmentfault.com/a/1190000006160703