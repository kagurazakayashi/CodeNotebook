// JS判断横屏竖屏


// JS通过window.orientation来获取屏幕的方向，值为0表示竖屏，值为90或-90表示横屏。

window.addEventListener("orientationchange", function () {
    if (window.orientation == 0) {
        // 竖屏
    } else {
        // 横屏
    }
});



// 通过JS计算设备宽高比例来判断屏幕方向

var viewportWidth = window.innerWidth;
var viewportHeight = window.innerHeight;
var aspectRatio = viewportWidth / viewportHeight;

if (aspectRatio < 1) {
  // 竖屏
} else {
  // 横屏
}
