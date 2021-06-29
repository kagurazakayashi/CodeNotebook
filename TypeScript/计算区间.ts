/**
 * 区间计算，检查数值是否在区间中
 * @param {string} scope 区间描述 "[15]","(,15)","[15,35)"
 * @param {number} value 数值
 * @return {boolean} 数值是否在区间中
 */
 function scopeCalc1(scope: string, value: number): boolean {
    const incStart: number = (scope.substring(0, 1) == '[') ? 0 : 1;
    const incEnd: number = (scope.substring(scope.length - 1) == ']') ? 0 : -1;
    const scopeArr: string[] = scope.substring(1, scope.length - 1).split(',');
    if (incStart == 0 && incEnd == 0 && scopeArr.length == 1) {
        return (parseFloat(scope) == value);
    }
    if (scopeArr[0].length > 0) {
        let minVal: number = parseFloat(scopeArr[0]);
        minVal += incStart;
        if (value < minVal) {
            return false;
        }
    }
    if (scopeArr[1].length > 0) {
        let maxVal: number = parseFloat(scopeArr[1]);
        maxVal += incEnd;
        if (value > maxVal) {
            return false;
        }
    }
    return true;
}

/**
 * 区间计算，保持某个数值为最小值或最大值
 * @param {string} scope 区间描述 "(,15)","[15,35)"
 * @param {number} value 数值
 * @return {number} 过滤后数值
 */
function scopeCalc2(scope: string, value: number): number {
    const incStart: number = (scope.substring(0, 1) == '[') ? 0 : 1;
    const incEnd: number = (scope.substring(scope.length - 1) == ']') ? 0 : -1;
    const scopeArr: string[] = scope.substring(1, scope.length - 1).split(',');
    if (scopeArr[0].length > 0) {
        let minVal: number = parseFloat(scopeArr[0]);
        minVal += incStart;
        if (value < minVal) {
            return minVal;
        }
    }
    if (scopeArr[1].length > 0) {
        let maxVal: number = parseFloat(scopeArr[1]);
        maxVal += incEnd;
        if (value > maxVal) {
            return maxVal;
        }
    }
    return value;
}