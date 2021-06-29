/**
 * 调整颜色亮度
 * @param {string} hex 16进制颜色
 * @param {number} light 亮度调节(正负数字)
 * @param {boolean} holdColor 保持RGB比例
 * @return {string} 修改后的16进制颜色
 */
function colorLight(hex: string, light: number = 20, holdColor = false): string {
    const rgbaHex: string[] = ['', '', ''];
    const rgbaInt: number[] = [0, 0, 0];
    const cLen = hex.length;
    if (cLen == 4 || cLen == 6) {
        for (let i = 0; i < 3; i++) {
            rgbaInt[i] = parseInt('0x' + hex.substr(i + 1, 1));
        }
    } else if (cLen == 7 || cLen == 9) {
        let j: number = 1;
        for (let i = 0; i < 3; i++) {
            rgbaInt[i] = parseInt('0x' + hex.substr(j, 2));
            j += 2;
        }
    }
    if (holdColor) {
        forI:
        for (let i = 0; i < light; i++) {
            for (let j = 0; j < 3; j++) {
                if ((rgbaInt[j] + 1) > 255) {
                    break forI;
                }
            }
            for (let j = 0; j < 3; j++) {
                rgbaInt[j]++;
            }
        }
    } else {
        for (let i = 0; i < 3; i++) {
            let cInt: number = rgbaInt[i] + light;
            if (cInt > 255) {
                cInt = 255;
            }
            rgbaInt[i] = cInt;
        }
    }
    for (let i = 0; i < 3; i++) {
        if (rgbaInt[i] > 0) {
            rgbaHex[i] = rgbaInt[i].toString(16);
        }
        const chHex: string = rgbaHex[i];
        if (chHex.length == 1) {
            rgbaHex[i] = '0' + chHex;
        }
    }
    let newHex = '#' + rgbaHex.join('');
    if (cLen == 6) {
        newHex += hex.substr(4, 1);
    } else if (cLen == 9) {
        newHex += hex.substr(7, 2);
    }
    return newHex;
}