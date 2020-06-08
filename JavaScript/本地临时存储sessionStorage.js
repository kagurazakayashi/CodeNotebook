// sessionStorage生命周期为当前窗口或标签页，一旦窗口或标签页被永久关闭了，那么所有通过sessionStorage存储的数据也就被清空了。

// 保存数据：
sessionStorage.setItem("key", "value");
// 读取数据：
var lastname = sessionStorage.getItem("key");
// 删除指定键的数据：
sessionStorage.removeItem("key");
// 删除所有数据：
sessionStorage.clear();
// 是否存在
if (sessionStorage.getItem("key") != null) {
    alert('key 存在');
} else { 
    alert('key 不存在');
}

// 以下实例用于记录点击按钮的次数
function clickCounter() {
    if(typeof(Storage) !== "undefined") {
        if (sessionStorage.clickcount) {
            sessionStorage.clickcount = Number(sessionStorage.clickcount)+1;
        } else {
            sessionStorage.clickcount = 1;
        }
        document.getElementById("result").innerHTML = "你在按钮上已经点击了 " + sessionStorage.clickcount + " 次。";
    } else {
        document.getElementById("result").innerHTML = "Sorry, your browser does not support web storage...";
    }
}

// https://www.runoob.com/jsref/prop-win-sessionstorage.html