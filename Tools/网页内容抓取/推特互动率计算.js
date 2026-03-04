/* 推特互动率计算脚本 v2025
该脚本会根据贴文显示的查看数，计算千分比互动率，帮助了解推文概况。
在贴文列表页，把全部代码粘贴到F12的控制台后回车即可。
# 示例1:
推文列表下方的按钮区如下显示：
评论 4  转发 3  喜欢 124  查看 7281
脚本执行后，这里会变成：
评论 4(0.55‰)  转发 3(0.41‰)  喜欢 124(17.03‰)  查看 7281(17.99‰)
# 示例2:
推文列表下方的按钮区如下显示：
评论 9  转发 3461  喜欢 2.9万  查看 48万
脚本执行后，这里会变成：
评论 9(0.02‰)  转发 3461(7.21‰)  喜欢 2.9万(60.42‰)  查看 48万(67.65‰)
# 括号里面的内容分别为：
评论互动率，转发互动率，喜欢互动率，互动评分。
- 如果显示的是 万/M/K ，则直接乘以相应位数换算回普通数值（不会进一步向推特服务器请求查询具体数值）。建议在简繁中文或英语下使用。
- 该脚本不会产生额外的网络查询。每次统计之前，建议先刷新一下网页。
*/
console.log("推特互动率计算脚本v2025 by 神楽坂雅詩");
(function() {
  const parse = t => {
    let s = t.replace(/,/g, ''), n = parseFloat(s.match(/[\d.]+/)?.[0] || 0);
    return /m/i.test(s) ? n * 1e6 : /k/i.test(s) ? n * 1e3 : /[^\d.\s]/.test(s) ? n * 1e4 : n;
  };
  const run = () => document.querySelectorAll('article[data-testid="tweet"]:not([p])').forEach(t => {
    const s = t.querySelectorAll('span[data-testid="app-text-transition-container"]');
    if (s.length < 4) return;
    const nums = [0, 1, 2, 3].map(i => parse(s[i].innerText));
    const view = nums[3] || 1;
    [nums[0], nums[1], nums[2], nums[0]+nums[1]+nums[2]].forEach((v, i) => {
      const el = document.createElement('span');
      el.innerText = `(${(v / view * 1000).toFixed(2)}‰)`;
      s[i].appendChild(el);
    });
    t.setAttribute('p', 1);
  });
  new MutationObserver(run).observe(document.body, {childList: true, subtree: true});
  run();
})();
