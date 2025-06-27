# Yubikey使用Bitlocker

## 修改组策略配置标识符

绑定需要修改组策略允许自签，解锁不需要修改。

运行 `gpedit.msc`，在本地组策略编辑器窗口中定位到：`计算机配置 – 管理模板 – BitLocker 驱动器加密 – 验证智能卡证书使用合规性`，点选`已启用`。对象标识符 `1.3.6.1.4.1.311.67.1.1` 保持默认，点击确定。

## 修改注册表允许自签

运行 `regedit`

1. 在注册表编辑器窗口定位到：`计算机\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\FVE`
2. 右键新建一个名为 `SelfSignedCertificates` 的 `Dword` 值，数据为 `1`。随后重启电脑使注册表生效。

```reg
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\FVE]
"SelfSignedCertificates"=dword:00000001
"CertificateOID"="1.3.6.1.4.1.311.67.1.1"
```

## 生成自签名证书

1. 将以下内容保存为一个 txt 文件: `yubikey-bitlocker.csr` (文件名扩展名随便)

```ini
[NewRequest]
Subject = "CN=BitLocker"
KeyLength = 2048
HashAlgorithm = Sha256
Exportable = TRUE
KeySpec = "AT_KEYEXCHANGE"
KeyUsage = "CERT_KEY_ENCIPHERMENT_KEY_USAGE"
KeyUsageProperty = "NCRYPT_ALLOW_DECRYPT_FLAG"
RequestType = Cert
SMIME = FALSE
ValidityPeriodUnits = 99
ValidityPeriod = Years

[EnhancedKeyUsageExtension]
OID=1.3.6.1.4.1.311.67.1.1
```

增强用途版本（已实测）：

```ini
[ req ]
default_bits       = 2048
default_keyfile    = privkey.pem
default_md         = sha256
prompt             = no
encrypt_key        = no
distinguished_name = req_distinguished_name
req_extensions     = bitlocker_ext

[ req_distinguished_name ]
CN = BitLockerSmartCard
O  = Personal
C  = XX

[ bitlocker_ext ]
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = clientAuth, 1.3.6.1.4.1.311.20.2.2, 1.3.6.1.4.1.311.10.3.4, 1.3.6.1.4.1.311.67.1.1
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid
```

别动那个 `KeyLength = 2048`，设置成 4096 导入不进去。

2. 在 `cmd` 中运行：

GUI 模式：

```cmd
certreq -new BitLocker.csr
```

    1. 此时会提示 `CertReq: 已创建并安装证书`，并弹出一个文件保存窗口。将这个文件保存在任意位置均可：`BitLocker.req` (文件名扩展名随便)
    2. 在开始菜单键入 `certmgr.msc` 并回车，在证书管理器窗口中定位到：`个人 – 证书`，并找到刚刚创建的名为 `BitLocker` 的证书，右键点选 `所有任务 – 导出`。
    3. 在导出向导中的第一部选择 `是，导出私钥`，第二步选择 `如果导出成功，删除私钥`，其余均可默认。按照提示设置一个导出文件密码，保存证书到文件。 `BitLocker.pfx` (文件名随便)

命令行模式（已实测）：

```bash
# 生成私钥（测试 4096 不支持导入）
openssl genrsa -out BitLocker.key 2048
# 生成证书请求
openssl req -new -key BitLocker.key -out BitLocker.csr -subj "/CN=YashiBitLockerSmartCard"
# 自签证书（有效期10年）
openssl x509 -req -in BitLocker.csr -signkey BitLocker.key -out BitLocker.crt -days 3650 -extfile BitLocker.cnf -extensions bitlocker_ext
# 打包成一个 .pfx：
openssl pkcs12 -export -out BitLocker.pfx -inkey BitLocker.key -in BitLocker.crt
# 导入证书到 YubiKey PIV 槽（9a），010203040506070801020304050607080102030405060708 是默认管理密钥，已更改则用自己的
yubico-piv-tool -a import-key -s 9a -i BitLocker.key -k 010203040506070801020304050607080102030405060708
yubico-piv-tool -a import-certificate -s 9a -i BitLocker.crt -k 010203040506070801020304050607080102030405060708
# 查看已导入
yubico-piv-tool -a status
# 查看 Windows 认的智能卡信息
certutil -scinfo
```

`yubico-piv-tool` 的操作可以在 `YubiKey Manager` GUI 中操作：

## 导入证书到 YubiKey

打开 `YubiKey Manager` ，定位到 `Applications – PIV – Configure Certificates – Slot 9a` ，点击 `Import` 。选择上一步中导出的 `.pfx` ，输入上一步中设置的密码，将证书导入到 `YubiKey` 中。

如果有多个 YubiKey ，重复该步骤逐个导入即可。

## 绑定 BitLocker

`控制面板\所有控制面板项\BitLocker 驱动器加密`

做完了以上步骤之后我们终于可以将 YubiKey 绑定到 BitLocker 了，只需要先解锁磁盘，在控制面板中选择添加智能卡即可。添加和移除都是瞬间完成的，如果你有多个 YubiKey 只需要绑定一个即可，前提是导入了同样的 `.pfx` 证书。

后续解锁时选择“使用智能卡”解锁磁盘，只需要插入 YubiKey 并输入 PIN 即可。

## 其他说明

在绑定过程中使用过的 cert.txt 以及导出的申请文件没有泄密风险，且无需保留可直接删除。在系统中创建的 BitLocker 个人证书无需备份，也不需要删除，但请务必操作一次导出。无论是否选择删除私钥，私钥都只能被导出一次。

如果后续不会再增加新的 YubiKey 或者同类智能卡硬件，导出的 cert.pfx 可以直接文件粉碎。反之则请将其保存在安全的位置，并牢记导出时设置的证书密码。已经导入到 YubiKey 的证书，再导出时只包含公钥，无法用于解密和复制到其他的 YubiKey 。如果 cert.pfx 已经删除还需要增加 YubiKey ，则只能解除绑定重新开始。

如果需要解除绑定，可以解锁硬盘后在控制面板操作。

本文参考了 https://nathanaelfrey.com/2021/01/09/setting-up-bitlocker-with-yubikey-as-smart-card/

本文参考了 https://roov.org/2023/03/yubikey-and-bitlocker/
