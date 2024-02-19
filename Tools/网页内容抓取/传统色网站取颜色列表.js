// 用于 https://nipponcolors.com/ 日本传统色
// Color data cited: “日本の伝統色 The Traditional Colors of Japan”. PIE BOOKS, 2007.
function nipponcolors() {
    const ul = document.getElementById("colors");
    const lis = ul.getElementsByTagName("li");
    const list = [];
    for (let i = 0; i < lis.length; i++) {
        const li = lis[i];
        const cid = parseInt(li.id.replace(/[^0-9]/ig, ""));
        const a = li.getElementsByTagName("a")[0];
        const style = window.getComputedStyle(a, null);
        const colorRGB = style.getPropertyValue("-webkit-tap-highlight-color").replace(/[^0-9,]/ig, "").split(",");
        let hex = "";
        for (const nColor of colorRGB) {
            const hexadecimal = parseInt(nColor).toString(16);
            hex += hexadecimal.length == 1 ? "0" + hexadecimal : hexadecimal;
        }
        hex = hex.toUpperCase();
        const names = a.innerText.split(", ");
        const dataStr = [names[0], names[1], hex].join(",");
        list.push(dataStr);
    }
    printColors(list.join("|"));
}

// 用于 http://zhongguose.com/ 中国传统色
// 《色谱》. 中科院科技情报编委会名词室. 科学出版社, 1957.
function zhongguose() {
    const ul = document.getElementById("colors");
    const lis = ul.getElementsByTagName("li");
    const list = [];
    for (let i = 0; i < lis.length; i++) {
        const li = lis[i];
        const a = li.getElementsByTagName("a")[0];
        const name = a.getElementsByClassName("name")[0].innerText;
        const pinyin = a.getElementsByClassName("pinyin")[0].innerText;
        const color = a.getElementsByClassName("rgb")[0].innerText.toUpperCase();
        const dataStr = [name, pinyin, color].join(",");
        list.push(dataStr);
    }
    printColors(list.join("|"));
}

// 控制台输出颜色
function printColors(str) {
    const colors = str.split("|");
    let returnStrArr = [];
    for (let i = 0; i < colors.length; i++) {
        const color = colors[i];
        const colorInfo = color.split(",");
        let preview = "";
        for (const iterator of colorInfo[2]) {
            preview += "█";
        }
        // 浏览器控制台输出
        console.log(i + "%c " + preview + " " + colorInfo.join(" "), "color: #" + colorInfo[2]);
        // Markdown 输出
        const reverse = colorReverse(colorInfo[2]);
        const font1 = ["<font color=#" + colorInfo[2] + ">", "</font>"];
        const font2 = ["<font color=#" + reverse + ">", "</font>"];
        const view = [
            (i + 1).toString(),
            font1[0] + preview + font1[1],
            font1[0] + colorInfo[0] + font1[1],
            font1[0] + colorInfo[1] + font1[1],
            font1[0] + "#" + colorInfo[2] + font1[1],
            font2[0] + preview + font2[1],
            font2[0] + "#" + reverse + font2[1],
        ];
        // returnStrArr.push("| " + view.join(" | ") + " |");
        // JS 输出
        returnStrArr.push('static ' + colorInfo[1].toLowerCase() + ' = "#' + colorInfo[2] + '"; // ' + colorInfo[0]);
    }
    console.log(returnStrArr.join("\n"));
}

// 反色
function colorReverse(oldColor) {
    const color = '0x' + oldColor.replace(/#/g, '');
    const str = '000000' + (0xFFFFFF - color).toString(16);
    return str.substring(str.length - 6, str.length).toUpperCase();
}