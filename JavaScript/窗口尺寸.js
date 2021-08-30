// 网页可见区域宽：
document.body.clientWidth
// 网页可见区域高：
document.body.clientHeight
// 网页可见区域宽：
document.body.offsetWidth (包括边线的宽)
// 网页可见区域高：
document.body.offsetHeight (包括边线的宽)
// 网页正文全文宽：
document.body.scrollWidth
// 网页正文全文高：
document.body.scrollHeight
// 网页被卷去的高：
document.body.scrollTop
// 网页被卷去的左：
document.body.scrollLeft
// 网页正文部分上：
window.screenTop
// 网页正文部分左：
window.screenLeft
// 屏幕分辨率的高：
window.screen.height
// 屏幕分辨率的宽：
window.screen.width
// 屏幕可用工作区高度：
window.screen.availHeight
// 屏幕可用工作区宽度：
window.screen.availWidth

// HTML精确定位:scrollLeft,scrollWidth,clientWidth,offsetWidth
// scrollHeight: 获取对象的滚动高度。
// scrollLeft:设置或获取位于对象左边界和窗口中目前可见内容的最左端之间的距离
// scrollTop:设置或获取位于对象最顶端和窗口中可见内容的最顶端之间的距离
// scrollWidth:获取对象的滚动宽度
// offsetHeight:获取对象相对于版面或由父坐标 offsetParent 属性指定的父坐标的高度
// offsetLeft:获取对象相对于版面或由 offsetParent 属性指定的父坐标的计算左侧位置
// offsetTop:获取对象相对于版面或由 offsetTop 属性指定的父坐标的计算顶端位置
// event.clientX 相对文档的水平座标
// event.clientY 相对文档的垂直座标
// event.offsetX 相对容器的水平坐标
// event.offsetY 相对容器的垂直坐标
// document.documentElement.scrollTop 垂直方向滚动的值
// event.clientX+document.documentElement.scrollTop 相对文档的水平座标+垂直方向滚动的量