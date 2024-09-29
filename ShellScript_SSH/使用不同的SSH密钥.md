# github防止ssh冲突 指定不同ssh密钥 不同网站用不同ssh密钥

## 创建的时候：

```bash
ssh-keygen -t ed25519 -C "test@test.test"
```

## 指定另一个文件名称：

Enter file in which to save the key (/home/yashi/.ssh/id_ed25519): 
/home/yashi/.ssh/id_ed25519_github

```
Your identification has been saved in /home/yashi/.ssh/id_ed25519_github
Your public key has been saved in /home/yashi/.ssh/id_ed25519_github.pub
```

## 上传

/home/yashi/.ssh/id_ed25519_github.pub

## 编辑 `~/.ssh/config` ：

```conf
# github
Host github.com
    HostName ssh.github.com
    Port 443
    User git
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_ed25519_github
```

## 测试连接：

```bash
ssh -T git@github.com
```
