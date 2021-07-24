/**
 * 检查数值是否在区间中
 * @param {string | number[]} scope 区间描述文字，如 "(0,10)" 或 区间数字数组 [最小值,最大值]
 * "(,100]"  : ∞ < x ≤ 100
 * "[0,100)" : 0 ≤ x < 100
 * @param {number[]} scope 区间数字数组 [最小值,最大值]
 * @param {number} value 要被测量的数字
 * @param {boolean} isNewNum 返回符合范围的 ±1 数字 (value 必须输入整数)
 * @return {number} isNewNum ? 符合范围的 ±1 数字 : (-1小于 0正常 1大于)
 */
function scopeCalc(scope: string | number[], value: number, isNewNum = false): number {
    const isNumArr = scope instanceof Array;
    const incStart: boolean = isNumArr ? true : ((scope as string).substring(0, 1) == '[');
    const incEnd: boolean = isNumArr ? true : ((scope as string).substring(scope.length - 1) == ']');
    const scopeArr: string[] = isNumArr ? [] : (scope as string).substring(1, scope.length - 1).split(',');
    if (isNumArr || scopeArr[0].length > 0) {
        const minVal: number = isNumArr ? (scope as number[])[0] : parseFloat(scopeArr[0]);
        if (incStart) {
            if (value < minVal) {
                // console.log(`数值 ${value} 小于 等于标准值 ${scope} 中的 ${minVal}`);
                return isNewNum ? minVal : -1;
            }
        } else {
            if (value <= minVal) {
                // console.log(`数值 ${value} 小于 标准值 ${scope} 中的 ${minVal}`);
                return isNewNum ? minVal + 1 : -1;
            }
        }
    }
    if (isNumArr || scopeArr[1].length > 0) {
        const maxVal: number = isNumArr ? (scope as number[])[1] : parseFloat(scopeArr[1]);
        if (incEnd) {
            if (value > maxVal) {
                // console.log(`数值 ${value} 大于等于 标准值 ${scope} 中的 ${maxVal}`);
                return isNewNum ? maxVal : 1;
            }
        } else {
            if (value >= maxVal) {
                // console.log(`数值 ${value} 大于 标准值 ${scope} 中的 ${maxVal}`);
                return isNewNum ? maxVal - 1 : 1;
            }
        }
    }
    // console.log(`数值 ${value} 在此区间 ${scope}`);
    return isNewNum ? value : 0;
}

/* 
YQ测试 - scopeCalc
tsc 计算区间.ts && node 计算区间.js && rm -f 计算区间.js
*/
function scopeCalcTest(scope: string | number[], value: number, limit = false) {
    console.log(scope, value, limit, ' => ', scopeCalc(scope, value, limit));
    console.log('-');
}
console.log('整数数值限制测试：');
console.log('-');
scopeCalcTest('[0,100]', 100, true);
scopeCalcTest('[0,100)', 100, true);
scopeCalcTest('[0,100]', 101, true);
scopeCalcTest('[0,100)', 101, true);
scopeCalcTest('[0,100)', 0, true);
scopeCalcTest('(0,100)', 0, true);
scopeCalcTest('(0,100)', -1, true);
scopeCalcTest('[0,100)', -1, true);
scopeCalcTest([0, 100], -1, true);
console.log('整数数范围判断测试：');
console.log('-');
scopeCalcTest('[0,200]', 200, false);
scopeCalcTest('[0,200)', 200, false);
scopeCalcTest('[0,200]', 201, false);
scopeCalcTest('[0,200)', 201, false);
scopeCalcTest('[0,200)', 0, false);
scopeCalcTest('(0,200)', 0, false);
scopeCalcTest('(0,200)', -1, false);
scopeCalcTest('[0,200)', -1, false);
scopeCalcTest([0, 200], -1, false);
console.log('浮点数范围判断测试：');
console.log('-');
scopeCalcTest('(0,100)', 0.123456, false);
scopeCalcTest('[0,100)', 0.123456, false);
scopeCalcTest('(0,100)', -0.123456, false);
scopeCalcTest('[0,100)', -0.123456, false);
scopeCalcTest('(0,100)', 100.123456, false);
scopeCalcTest('(0,100]', 100.123456, false);
scopeCalcTest([0, 100], 100.123456, false);