在 Linux 中访问 Windows 共享文件夹，可以使用 `cifs-utils` 通过 CIFS/SMB 协议进行访问。以下是几种常见的方法：

---

## 1. **临时挂载（适用于临时访问，不会持久化）**
如果只是临时访问 Windows 共享文件夹，可以使用 `mount -t cifs` 命令：

### **步骤 1：安装 cifs-utils**
首先，确保 Linux 机器上已安装 `cifs-utils`：
```bash
sudo apt update && sudo apt install -y cifs-utils  # Debian/Ubuntu
sudo yum install -y cifs-utils  # CentOS/RHEL
sudo dnf install -y cifs-utils  # Fedora
```

### **步骤 2：创建挂载目录**
```bash
sudo mkdir -p /mnt/windows_share
```

### **步骤 3：挂载 Windows 共享目录**
```bash
sudo mount -t cifs -o username=your_user,password=your_password,vers=3.0 //192.168.1.100/shared_folder /mnt/windows_share
```
- **`//192.168.1.100/shared_folder`**：Windows 共享文件夹地址（可以使用 IP 或计算机名）。
- **`/mnt/windows_share`**：Linux 挂载点。
- **`username=your_user,password=your_password`**：Windows 账户和密码。
- **`vers=3.0`**：指定 SMB 版本（可尝试 `2.0` 或 `1.0`，如果 `3.0` 无法工作）。

### **步骤 4：验证挂载**
```bash
ls /mnt/windows_share
```
如果挂载成功，可以看到 Windows 共享文件夹的内容。

### **步骤 5：卸载**
当不再需要访问共享时，可以卸载：
```bash
sudo umount /mnt/windows_share
```

---

## 2. **持久挂载（适用于长期使用，每次重启后仍可访问）**
如果想要在系统启动时自动挂载 Windows 共享文件夹，可以修改 `/etc/fstab`。

### **步骤 1：创建凭据文件（可选，增强安全性）**
为了避免密码明文存储在 `/etc/fstab`，建议创建一个凭据文件：
```bash
sudo nano /etc/smbcredentials
```
添加以下内容：
```
username=your_user
password=your_password
```
保存并退出，然后设置权限：
```bash
sudo chmod 600 /etc/smbcredentials
```

### **步骤 2：编辑 /etc/fstab**
打开 `/etc/fstab`：
```bash
sudo nano /etc/fstab
```
添加如下行：
```
//192.168.1.100/shared_folder /mnt/windows_share cifs credentials=/etc/smbcredentials,vers=3.0,iocharset=utf8,file_mode=0777,dir_mode=0777 0 0
```
参数说明：
- `credentials=/etc/smbcredentials`：从凭据文件读取用户名和密码（避免明文存储）。
- `vers=3.0`：指定 SMB 版本（可调整）。
- `iocharset=utf8`：保证中文文件名正常显示。
- `file_mode=0777,dir_mode=0777`：设置文件夹和文件的权限。

### **步骤 3：应用更改**
```bash
sudo mount -a
```
验证 `/mnt/windows_share` 目录是否成功挂载。

---

## 3. **使用 smbclient 直接访问（不挂载）**
如果不想挂载 Windows 共享文件夹，只是偶尔访问，可以使用 `smbclient`：

### **步骤 1：安装 smbclient**
```bash
sudo apt install smbclient  # Debian/Ubuntu
sudo yum install samba-client  # CentOS/RHEL
sudo dnf install samba-client  # Fedora
```

### **步骤 2：访问共享文件夹**
```bash
smbclient -L //192.168.1.100 -U your_user
```
它会列出 `192.168.1.100` 机器上的共享目录。

然后，访问某个共享文件夹：
```bash
smbclient //192.168.1.100/shared_folder -U your_user
```
输入密码后，就可以使用交互式 `smb>` 终端来操作文件，例如：
```bash
smb: \> ls
smb: \> get myfile.txt
smb: \> put localfile.txt
smb: \> exit
```

---

## 4. **故障排查**
如果访问失败，可以尝试以下方法排查：

### **1) 检查 Windows 共享是否开启**
在 Windows 端：
- 确保 "文件和打印机共享" 已启用：
  ```cmd
  net share
  ```
- 检查 Windows 防火墙是否允许文件共享。

### **2) 检查 SMB 版本**
某些新版本 Windows 可能禁用了 SMBv1，而旧版本 Linux 默认使用 SMBv1：
```bash
smbclient -L //192.168.1.100 -m SMB3
```
如果 `SMB3` 不支持，可以尝试 `SMB2` 或 `SMB1`。

### **3) 确保 Linux 端已安装 `cifs-utils`**
```bash
dpkg -l | grep cifs-utils  # Debian/Ubuntu
rpm -q cifs-utils  # CentOS/RHEL
```
