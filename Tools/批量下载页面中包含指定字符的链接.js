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
