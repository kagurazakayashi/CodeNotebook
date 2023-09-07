# htop颜色

## CPU：
-  `|` 蓝色=低优先级线程
-  `#` 绿色=普通优先级线程
-  `*` 红色=内核线程
- 橙色=有效时间（窃取时间+访客时间）

## MEM：
-  `|` 绿色=已用内存
-  `#` 蓝色=缓冲区
-  `*` 黄色/橙色=缓存

## CPU详细模式

- 蓝色：低优先级线程（nice> 0）
- 绿色：正常（用户）流程
- 红色：系统进程
- 橙色：IRQ时间
- 洋红色：IRQ时间较慢
- 灰色：IO等待时间
- 青色：偷时间
- 青色：访客时间

您在Amazon EC实例上看到橙色的CPU条（2016年8月），则很可能是因为您所谓的“ CPU积分”用完了，CPU受到了限制。