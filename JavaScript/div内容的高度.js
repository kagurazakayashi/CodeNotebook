var div = document.getElementById("div");

// div文档总高度
var scrollHeight = div.scrollHeight;

// 获取div窗口显示高度
var offsetHeight = div.offsetHeight;

// 获取div卷上去的高度
var scrollTop = div.scrollTop;

// 高度差（或小于div高度时的总高度）
var overflowHeight = scrollHeight - offsetHeight;

// 滑动距离占总高度的百分比
var top = (scrollTop / allheight) * 100;
