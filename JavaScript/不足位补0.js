// 方法1
function PrefixInteger(num, length) {
    return (num / Math.pow(10, length)).toFixed(length).substr(2);
}
// 方法2，更为高效
function PrefixInteger(num, length) {
    return ("0000000000000000" + num).substr(-length);
}
// 方法3，还有更高效的
function PrefixInteger(num, length) {
    return (Array(length).join('0') + num).slice(-length);
}
// http://www.jb51.net/article/62499.htm