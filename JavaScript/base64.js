// JS base64
btoa('hello'); // 'aGVsbG8='
atob('aGVsbG8='); // 'hello'

// 中文乱码
window.btoa(encodeURIComponent('中文')); // "JUU0JUI4JUFEJUU2JTk2JTg3"
decodeURIComponent(window.atob('JUU0JUI4JUFEJUU2JTk2JTg3')); // "中文"