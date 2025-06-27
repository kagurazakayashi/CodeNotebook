TITLE chkdsk开机扫描硬盘

ECHO 使用 chkntfs 明确安排下次重启检查
CHKNTFS /C C:
ECHO 取消
CHKNTFS /X C:

ECHO 或使用 fsutil dirty 强制标记磁盘为“脏”
fsutil dirty set C:
