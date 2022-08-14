import Pako from 'pako'; // npm install pako @types/pako
import * as base64 from 'byte-base64'; // @types/pako
// Pako 压缩解压字符串 输出 base 64
const d8 = Pako.deflate(document.body.innerHTML, {
    level: 9,
    windowBits: 15,
    memLevel: 9,
    raw: false,
});
const d64 = base64.bytesToBase64(d8);
const ok = Pako.inflate(base64.base64ToBytes(d64), { to: 'string' });
console.log(ok);
