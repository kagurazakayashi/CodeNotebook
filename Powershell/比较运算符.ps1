# -eq ：等于
# -ne ：不等于
# -gt ：大于
# -ge ：大于等于
# -lt ：小于
# -le ：小于等于
# -contains ：包含
# -notcontains :不包含

# -and ：和
# -or ：或
# -xor ：异或
# -not ：逆

(3,4,5 ) -contains 2
# False
(3,4,5 ) -contains 5
# True
(3,4,5 ) -notcontains 6
# True
2 -eq 10
# False
"A" -eq "a"
# True
"A" -ieq "a"
# True
"A" -ceq "a"
# False
1gb -lt 1gb+1
# True
1gb -lt 1gb-1
# False

$a= 2 -eq 3
$a
# False
-not $a
# True
!($a)
# True

$true -and $true
# True
$true -and $false
# False
$true -or $true
# True
$true -or $false
# True
$true -xor $false
# True
$true -xor $true
# False
 -not  $true
# False

# 比较数组和集合
1,2,3,4,3,2,1 -eq 3
# 3
# 3
1,2,3,4,3,2,1 -ne 3
# 1
# 2
# 4
# 2
# 1

# 验证一个数组是否存在特定元素
$help=(man ls)
1,9,4,5 -contains 9
# True
1,9,4,5 -contains 10
# False
1,9,4,5 -notcontains 10
# True