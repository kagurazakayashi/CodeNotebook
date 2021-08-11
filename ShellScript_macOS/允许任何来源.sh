sudo spctl --master-disable
# 执行上述步骤之后，“任何来源”选项就会出现了。需要注意的是，如果在系统偏好设置的“安全与隐私”中重新选中允许“App Store”和“被认可的开发者”，即重新打开Gatekeeper后，允许“任何来源”的选项会再次消失，可运行上述命令再次关闭Gatekeeper。



# 允许单一应用
# 如果是最新的macOS 10.15 则需要进行以下操作：
# 在终端中粘贴下面命令：
sudo xattr -r -d com.apple.quarantine [应用.app路径]
# 例如：
sudo xattr -r -d com.apple.quarantine /Applications/qq.app/