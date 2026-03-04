/* 批量删除 QQ 空间说说脚本 v2024
为什么 QQ 空间删除自己的黑历史非得一条条删啊！
先进入自己的说说列表页面，把全部代码粘贴到F12的控制台后回车即可，
每隔 2 秒（也就是 2000 毫秒，可以在下面改）自动点删除按钮，
每隔 5 秒（也就是 5000 毫秒，可以在下面改）自动点确认按钮，
直到本页说说逐渐自动删光后，
刷新网页并重新把全部代码粘贴到F12的控制台后回车删除下一批。
一次不要删除太多页，不然会弹出验证码，
如果弹验证码了关网页等一个小时再操作。
*/
console.log("批量删除QQ空间说说脚本v2024 by 神楽坂雅詩");
var dig = true;
function clickDel() {
  try {
    document.querySelector('.app_canvas_frame').contentDocument.querySelector('.del_btn').click();
  } catch{
    var a = document.querySelector('.app_canvas_frame').contentDocument.querySelector('.mod_pagenav_main').querySelectorAll('.c_tx');
    a[a.length - 1].click();
    dig = false;
    setTimeout(clickDel, 2000);
  }
  setTimeout(clickYes, dig ? 2000 : 5000);
  dig = true;
}
function clickYes() {
  document.querySelector('.qz_dialog_layer_btn').click();
  setTimeout(clickDel, 2000);
}
clickDel()
