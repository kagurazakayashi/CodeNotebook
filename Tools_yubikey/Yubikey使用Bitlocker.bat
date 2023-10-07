TITLE Yubikey使用Bitlocker

ECHO 「管理文件加密证书」向导
rekeywiz
ECHO 下一步
ECHO 创建新证书,下一步
ECHO 选存储在计算机上,别选其他的,因为除了要塞进yubikey,我们还打算备份一份
ECHO 备份的路径,注意保管备份文件,输入备份密码

ECHO 启动 YubiKey Manager 导入证书, 进入 PIV
"C:\Program Files\Yubico\YubiKey Manager\ykman-gui.exe"
ECHO 清除卡里的所有密钥和密码: Reset PIV
ECHO 设置 PIN: Configre
ECHO 选PIV/证书第一个9a的标签页,然后点import导入,选刚才制作的证书文件(pfx结尾)
ECHO 输入备份密码,输yubikey piv的pin码

ECHO 改注册表
Yubikey使用Bitlocker.reg

ECHO 配置本地策略
gpedit.msc
ECHO 管理模板 - windows组件 - BitLocker驱动器加密 - 验证智能卡证书使用合规性 - 启用
ECHO 左边「对象标识符」填和注册表中的一样

ECHO 控制面板\所有控制面板项\BitLocker 驱动器加密
ECHO 已加密的驱动器: 添加智能卡
ECHO 未加密的驱动器: 启用→使用智能卡解锁驱动器→备份恢复密钥防止卡丢失

REM https://www.jianshu.com/p/5b091212e84d
