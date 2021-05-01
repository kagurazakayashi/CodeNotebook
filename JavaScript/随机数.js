// 获取从 1 到 10 的随机整数，取 0 的概率极小。
Math.ceil(Math.random() * 10);

// 可均衡获取 0 到 1 的随机整数。
Math.round(Math.random());

// 可均衡获取 0 到 9 的随机整数。
Math.floor(Math.random() * 10);

// 基本均衡获取 0 到 10 的随机整数，其中获取最小值 0 和最大值 10 的几率少一半。
Math.round(Math.random() * 10);

// 生成[1,max]的随机数：
// max - 期望的最大值
parseInt(Math.random() * max, 10) + 1;
Math.floor(Math.random() * max) + 1;
Math.ceil(Math.random() * max);

// 生成[0,max]到任意数的随机数：
// max - 期望的最大值
parseInt(Math.random() * (max + 1), 10);
Math.floor(Math.random() * (max + 1));

// 生成[min,max]的随机数：
// max - 期望的最大值
// min - 期望的最小值
parseInt(Math.random() * (max - min + 1) + min, 10);
Math.floor(Math.random() * (max - min + 1) + min);

// https://www.cnblogs.com/starof/p/4988516.html