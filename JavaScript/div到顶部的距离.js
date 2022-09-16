// 获取div到顶部的距离 获取div盒子到浏览器视窗顶部的距离 绝对坐标

// 可以用getBoundingClientRect().top来获取div相对浏览器视窗的位置
let anchorOffset0 = document.querySelector('#baseInfo').getBoundingClientRect().top
console.log(anchorOffset0);

// https://blog.csdn.net/a1059526327/article/details/104037180