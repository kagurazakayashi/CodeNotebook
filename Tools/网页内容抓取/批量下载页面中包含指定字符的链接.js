// 批量下载页面中包含指定字符的链接
// const downloada = document.getElementsByTagName("a");

// 批量下载 golang 版本
const downloada = document.getElementsByClassName("download");
const dllist = [];
for (let i = 0; i < downloada.length; i++) {
    const href = downloada[i].getAttribute("href");
    if (href.indexOf(".windows-amd64.msi") >= 0) {
        dllist.push(window.location.protocol + "//" + window.location.host + href);
    }
}
console.log(dllist.join("\n"));

// 批量下载 flutter 版本
// ["flutter_windows_","-stable.zip"]
// ["flutter_macos_","-stable.zip"]
// ["flutter_linux_","-stable.tar.xz"]
const findstr = ["flutter_windows_","-stable.zip"]
const downloada = document.getElementsByTagName("a");
const dllist = [];
for (let i = 0; i < downloada.length; i++) {
    const href = downloada[i].getAttribute("href");
    if (href.length > findstr.join("").length && href.indexOf(findstr[0]) >= 0 && href.substring(href.length - findstr[1].length) == findstr[1]) {
        dllist.push((window.location.protocol + "//" + window.location.host + href).replace("https://docs.flutter.dev",""));
    }
}
console.log(dllist.join("\n"));
