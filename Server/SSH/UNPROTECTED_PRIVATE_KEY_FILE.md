```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@         WARNING: UNPROTECTED PRIVATE KEY FILE!          @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
Permissions for '~/.ssh/id_ed25519' are too open.
It is required that your private key files are NOT accessible by others.
This private key will be ignored.
Load key "~/.ssh/id_ed25519": bad permissions
git@github.com: Permission denied (publickey).
```

# Windows

`.ssh` 文件夹：属性 > 安全 > 高级

所有者：自己用户

√ 给所有子文件文件夹

禁用继承 -> 删除所有

# Linux

`chmod -R 700 ~/.ssh`
