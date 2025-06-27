TITLE Bitlocker每次启动都要输入恢复密钥才能进的解决
ECHO 如果你还没暂停 BitLocker 就修改了 BCD，会被永久判为“不可信状态”
ECHO 输入 48 位恢复密钥，成功进入系统后，继续以下操作

ECHO 查看当前保护器
manage-bde -protectors -get C:

ECHO 删除当前保护器（将恢复当前启动链的信任）
manage-bde -protectors -delete C: -type TPM

ECHO 重新添加 TPM 启动保护器
manage-bde -protectors -add C: -tpm

ECHO 可选：添加 PIN（二次身份验证，非必须）
manage-bde -protectors -add C: -tpmandpin
ECHO 可选：添加 密码（在系统启动阶段输入，非必须）
manage-bde -protectors -add C: -password
ECHO 可选：添加 USB密钥到 F:
manage-bde -protectors -add C: -startupkey F:

ECHO 完成后需要强制刷新并启用 BitLocker 启动保护，确保 BitLocker 已启用并使用 TPM 作为保护方式。
manage-bde -status C:
