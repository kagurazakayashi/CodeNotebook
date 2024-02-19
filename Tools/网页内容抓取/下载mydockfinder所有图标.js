// 批量下载 mydockfinder 所有图标
// by 神楽坂雅詩
const eGalleryItems = document.getElementsByClassName('e-gallery-item');
let links = [];
for (const k in eGalleryItems) {
    if (Object.hasOwnProperty.call(eGalleryItems, k)) {
        const eGalleryItem = eGalleryItems[k];
        const nowLink = eGalleryItem.href;
        if (nowLink.indexOf('http') != -1 && nowLink.indexOf('png') != -1) {
            links.push(eGalleryItem.href);
        }
    }
}
let wget = '';
for (let i = 0; i < links.length; i++) {
    const nowLink = 'wget "' + links[i] + '"\n';
    wget += nowLink;
}
console.log(wget);
// let linksI = 0;
// const dTimer = self.setInterval(function () {
//     const nowLink = links[linksI++];
//     if (linksI >= nowLink.length) {
//         window.clearInterval(dTimer);
//     } else {
//         window.open(nowLink);
//     }
// }, 1000);