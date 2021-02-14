# uniq (unique) 唯一，去除重复的行
# 去除【连续】重复的行并输出
uniq 1.txt
# 如果需要删除所有重复的行并输出，需要先用 shot 对文件行内容进行排序，把重复内容行排在相邻行，在一起去除
sort 1.txt | uniq
# https://zhuanlan.zhihu.com/p/26854210