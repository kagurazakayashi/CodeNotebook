# 查询已加载
kextstat

# 启动
kextstat -lb com.netease.nemu.kext.NemuDrv

# 查询
grep -q com.netease.nemu.kext.NemuDrv

# 卸载
kextunload -b com.netease.nemu.kext.NemuDrv #(ignoring failures)
kextunload -m com.netease.nemu.kext.NemuDrv