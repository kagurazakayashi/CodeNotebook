// 几秒后执行 延迟执行
setTimeout("window.location.reload()",5000);

// ECMAScript 6 (ES6/ES2015)
// 虽然早期浏览器支持以字符串形式传入（等同于内部 eval 执行），但这种写法不推荐（安全性、性能等问题）。现代写法更推荐函数形式：
setTimeout(() => window.location.reload(), 5000);
