# LF will be replaced by CRLF
# 问题出现的原因以及解决方式


# 自动转换:

# 提交时转换为 LF ，检出时转换为 CRLF
git config --global core.autocrlf true

# 提交时转换为 LF ，检出时不转换
git config --global core.autocrlf input

# 提交检出均不转换
git config --global core.autocrlf false


# 在文件提交时进行 safecrlf 检查:

# 拒绝提交包含混合换行符的文件
git config --global core.safecrlf true
 
# 允许提交包含混合换行符的文件
git config --global core.safecrlf false
 
# 提交包含混合换行符的文件时给出警告
git config --global core.safecrlf warn


# https://blog.csdn.net/huihuikuaipao_/article/details/100183521