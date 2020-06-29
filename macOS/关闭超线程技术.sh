# 将您的 Mac 开机或重新启动，然后立即按住键盘上的 Command (⌘)-R 或“macOS 恢复”的其他组合键。
nvram boot-args="cwae=2"
nvram SMTDisable=%01

# 重新启用超线程
# -> 重置 NVRAM: Option(Alt) + Command + P + R

# 检查超线程的状态
# 选取苹果菜单  >“关于本机”，点按“系统报告”按钮，然后在边栏中选择“硬件”。如果 Mac 中的处理器支持超线程，则“超线程技术”会显示为“已启用”或“已停用”。

# https://support.apple.com/zh-cn/HT210107