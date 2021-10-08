a = 3.75

# === 取整 ===

# 向下取整:
int(a)
# 3

# 四舍五入
round(a)
# 4.0

# 向上取整
import math
math.ceil(a)
# 4.0


a = 12.345

# === 保留两位小数，并做四舍五入处理 ===

# 方法一: 使用字符串格式化
print("%.2f" % a)
# 12.35

# 方法二: 使用round内置函数
round(a, 2)
# 12.35

# 方法三: 使用decimal模块
from decimal import Decimal
Decimal(a).quantize(Decimal("0.00"))
# Decimal('12.35')

# === 仅保留两位小数，无需四舍五入 ===

# 方法一: 使用序列中切片
str(a).split('.')[0] + '.' + str(a).split('.')[1][:2]
# '12.34'

# 方法二: 使用re模块
import re
re.findall(r"\d{1,}?\.\d{2}", str(a))
# ['12.34']
