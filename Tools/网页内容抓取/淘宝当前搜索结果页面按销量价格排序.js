/* 淘宝当前搜索结果页面按销量/价格排序脚本 v2025
解决只想排序 淘宝商品当前搜索结果页 的 按销量或者价格进行 从小到大或者从大到小排序的需要。
因为有时使用淘宝自带的全局排序并不理想，所以做了这个只对于当前页面的。
把全部代码粘贴到F12的控制台后回车即可，
代码会在控制台输出一个排序列表，包括当前值和商品名称和链接，不改变原网页内容。
最后一行 ysMaxSolds(A,B); 可配置选项：
A = 0:销量; 1:价格
B = 0:从小到大; 1:从大到小
例如 (0,0) 就是 销量从小到大; 设为 (1,1) 就是 价格从大到小;
在翻页后只需要运行 ysMaxSolds(你的配置); 即可。
其他情况需要重新把下面全部代码重新粘贴到网页控制台后回车。
如果显示未找到数据可能是网页改版了脚本旧了，或者是页面还没载入完毕。 */
console.log("淘宝当前搜索结果页面按销量/价格排序脚本v2025 by 神楽坂雅詩");
const ysMaxSolds = (m, d) => {
  const k = [["销量", "realSales"], ["价格", "innerPriceWrapper"]][m];
  const l = [...document.querySelectorAll('[class*="doubleCardWrapperAdapt"]')].flatMap(c =>
    [...c.querySelectorAll(`[class^="${k[1]}"]`)].map(s => [
      +(s.innerText.match(/[\d.]+/)?.[0]) || 0,
      c.innerText.split('\n')[0], c.href
    ])
  );
  if (!l.length) return console.error("未找到数据");
  l.sort((a, b) => d ? b[0] - a[0] : a[0] - b[0]);
  console.log("▼".repeat(20));
  l.forEach(i => console.log(...i));
  console.log("▲".repeat(20));
  return [l.length, "个商品", k[0], d ? "降序" : "升序",
  "最大值:", d ? l[0][0] : l[l.length - 1][0]];
};
ysMaxSolds(0, 0);
