gpedit.msc
@REM 计算机配置 - 管理模板 - Windows 组件 - BitLocker 驱动器加密 - 操作系统驱动器 - 要求使用附加身份验证 - 已启用
@REM 允许使用 TPM 启动，允许使用 TPM + PIN 启动
@REM 注册表方式完成上述操作：
reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v UseAdvancedStartup /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v UseTPM /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v UseTPMAndPIN /t REG_DWORD /d 1 /f

@REM 为 BitLocker 添加 PIN
manage-bde -protectors -add C: -TPMAndPIN
@REM 系统会提示你输入 PIN（通常为 6-20 位数字），每次启动电脑时都需输入此 PIN。

@REM 自定义复杂 PIN（如包含字母）：
manage-bde -protectors -add C: -TPMAndPIN -pin "自定义PIN"

@REM 验证是否生效，查看当前保护器状态：
manage-bde -status C:
manage-bde -protectors -get C:
@REM TPM And PIN
@REM ID: {xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}
如果你忘记 PIN，你必须使用 恢复密钥 解锁。清除 TPM，BitLocker 也可能要求输入恢复密钥。PIN 不支持空格。建议避免使用“0”开头或重复数字。
