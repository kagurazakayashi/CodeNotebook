#!/bin/bash
OPENCC_EXEC=/Volumes/d/OpenCC/build/rel/src/tools/opencc
OPENCC_DATA_DIR=/Volumes/d/OpenCC/data/config
OPENCC_TEMP=/Volumes/r
touch "$OPENCC_TEMP/opencctemp.txt"
chmod 777 "$OPENCC_TEMP/opencctemp.txt"
SRC_STR=$(pbpaste)
echo "$SRC_STR" > "$OPENCC_TEMP/opencctemp.txt"
result=`$OPENCC_EXEC --input "$OPENCC_TEMP/opencctemp.txt" --config "$OPENCC_DATA_DIR/s2twp.json"`
echo "$result"
echo -n "$result" | pbcopy
rm -f "$OPENCC_TEMP/opencctemp.txt"
unset SRC_STR
unset result
unset OPENCC_TEMP
unset OPENCC_EXEC

# 自动操作.app
# 获取剪贴板内容
# ↓
# 运行Shell脚本: /Volumes/d/OpenCC/build/rel/src/tools/opencc --config /Volumes/d/OpenCC/data/config/s2twp.json
# ↓
# 拷贝至剪贴板
