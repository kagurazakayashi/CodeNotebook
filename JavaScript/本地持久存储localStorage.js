// localStorage生命周期是永久，这意味着除非用户显示在浏览器提供的UI上清除localStorage信息，否则这些信息将永远存在。

// 保存数据：
localStorage.setItem("key", "value");
// 读取数据：
var lastname = localStorage.getItem("key");
// 删除数据：
localStorage.removeItem("key");
// 删除所有数据：
localStorage.clear();
// 是否存在
if (localStorage.getItem("key") != null) {
    alert('key 存在');
} else { 
    alert('key 不存在');
}

// 以下实例用于记录点击按钮的次数
function clickCounter() {
    if(typeof(Storage) !== "undefined") {
        if (localStorage.clickcount) {
            localStorage.clickcount = Number(localStorage.clickcount)+1;
        } else {
            localStorage.clickcount = 1;
        }
        document.getElementById("result").innerHTML = "你在按钮上已经点击了 " + localStorage.clickcount + " 次。";
    } else {
        document.getElementById("result").innerHTML = "Sorry, your browser does not support web storage...";
    }
}

// https://www.runoob.com/jsref/prop-win-localstorage.html