rand()函数用户获取随机数，具体用法如下：

rand()可以设置0个参数或者两个参数，如rand($min,$max)，$min表示从XX开始取值，$max表示最大只能为XX

例如：

<?php
echo rand() . "\n";//得到一个不定位数的随机数

echo rand(5, 15);//在5~15之间取一个数
?>

mt_rand() 用法跟rand()类似，但是mt_rand()的执行效率更高，平常使用也推荐用mt_rand().
