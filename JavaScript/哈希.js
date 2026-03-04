// JS 计算哈希

// crypto.subtle 是一个用于执行加密操作的 Web API，适用于现代浏览器。以下是一个计算字符串的 SHA-256 哈希值的示例：
async function getHash(str) {
    // 将字符串转换为一个 ArrayBuffer
    const encoder = new TextEncoder();
    const data = encoder.encode(str);
    // 使用 SHA-256 算法计算哈希值
    const hashBuffer = await crypto.subtle.digest('SHA-256', data);
    // 将 ArrayBuffer 转换为十六进制字符串
    const hashArray = Array.from(new Uint8Array(hashBuffer));
    const hashHex = hashArray.map(byte => byte.toString(16).padStart(2, '0')).join('');
    return hashHex;
}
// 使用示例
getHash('Hello, World!').then(console.log);


// 不使用异步
function getSHA256Hash(str) {
    const encoder = new TextEncoder();
    const data = encoder.encode(str);
    // 使用 SHA-256 算法计算哈希并返回 Promise
    return crypto.subtle.digest('SHA-256', data).then(hashBuffer => {
        const hashArray = Array.from(new Uint8Array(hashBuffer));
        return hashArray.map(byte => byte.toString(16).padStart(2, '0')).join('');
    });
}
// 示例
getSHA256Hash('Hello, World!').then(hash => {
    console.log(hash);
});



// 使用第三方库（如 js-md5, crypto-js 等）
// 首先安装 crypto-js： npm install crypto-js
// 然后使用它来计算字符串的哈希值
const CryptoJS = require('crypto-js');
const hash = CryptoJS.SHA256('Hello, World!').toString(CryptoJS.enc.Hex);
console.log(hash);
// 使用 MD5
const md5Hash = CryptoJS.MD5('Hello, World!').toString(CryptoJS.enc.Hex);
console.log(md5Hash); // 输出 MD5 哈希值
