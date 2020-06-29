# 导出配置
adb pull /data/data/jp.co.cygames.princessconnectredive/shared_prefs/jp.co.cygames.princessconnectredive.v2.playerprefs.xml

# 修改
# 0，假定你已刷完第一个号且未删除，或已正常游戏
# 备份你/data/data/包名/shared_prefs下的xml配置文件(名字带v2的那个)
# 1，【找到并删除】xml中name属性为以下三个值的string节点 (node)
# /*
# M3F1YSNkOnF0
# MHx5cg%3D%3D
# NnB%2FZDJpMHx5cg%3D%3D
# */
# 这三个node里的内容也是你的帐号凭据 (credential)
# 请小心操作，避免遗失或泄露给他人
# 2，【搜索】xml中【是否存在】以下字符串为name属性的节点
# NkxfRjRTCFdGUzJTCEhxRRVTEQ%3D%3D
# 如果没有，请另起一行添加以下内容为节点
# UnRvcAUCAJN2u%2FM%3D
# 如果有，删除并重新按上述内容添加节点
# 模板制作完成
# 3，完成后初次进游戏需要重新下200+M左右的数据

# 上传
adb push jp.co.cygames.princessconnectredive.v2.playerprefs.xml /data/data/jp.co.cygames.princessconnectredive/shared_prefs/