// 首行单独提取：
const table = document.getElementsByTagName('table')[0];
const trs = table.getElementsByTagName('tr');
const line0 = trs[0];
let tds = line0.getElementsByTagName('td');
const tabletap = [];
let rowcount = 0;
for (item in tds) {
    const txt = tds[item].innerText;
    if (txt) {
        rowcount++;
        tabletap.push(tds[item].innerText);
    }
}
// 遍历剩余行
tds = table.getElementsByTagName('td');
let nowcount = -1;
for (let i = rowcount; i < tds.length; i++) {
    const element = tds[i];
    nowcount++;
    if (nowcount >= rowcount) {
        nowcount = 0;
        console.log("=====");
    }
    console.log(element);
}