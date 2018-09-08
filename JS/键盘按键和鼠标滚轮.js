document.onkeydown = function wpNyarukoTabloidKey(event) {
    if (event.keyCode == 37 || event.keyCode == 38 || event.keyCode == 87 || event.keyCode == 65) {
        wpNyarukoTabloidTriangleClick(false);
    } else if (event.keyCode == 39 || event.keyCode == 40 || event.keyCode == 32 || event.keyCode == 83 || event.keyCode == 68 || event.keyCode == 13) {
        wpNyarukoTabloidTriangleClick(true);
    } else if (event.keyCode >= 48 && event.keyCode <= 57) {
        var keypage = event.keyCode - 48;
        if (keypage == 0) keypage = 10;
        wpNyarukoTabloidGoToPage(keypage);
    } else if (event.keyCode >= 96 && event.keyCode <= 105) {
        var keypage = event.keyCode - 96;
        if (keypage == 0) keypage = 10;
        wpNyarukoTabloidGoToPage(keypage);
    }
}

document.onmousewheel = function wpNyarukoTabloidMouse(e) {
    e = e || window.event;
    var scroll = 0;
    if (e.wheelDelta) {//E/O/C
        scroll = e.wheelDelta;
    } else if (e.detail) {//FF
        scroll = e.detail;
    }
    if (scroll > 0) {
        wpNyarukoTabloidTriangleClick(false);
    } else if (scroll < 0) {
        wpNyarukoTabloidTriangleClick(true);
    }
}
