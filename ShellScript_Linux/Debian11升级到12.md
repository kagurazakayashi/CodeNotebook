要将 Debian 11（Bullseye）升级到 Debian 12（Bookworm），请按照以下步骤进行：

---

## **升级前的准备工作**
1. **备份数据**
   - 备份所有重要数据，包括 `/etc`、`/var` 和 `/home` 目录，以及数据库等关键服务的数据。
   - 可以使用 `rsync` 或 `tar` 进行备份：
     ```bash
     sudo rsync -aAXv /etc /home /var /opt /root /backup/
     ```

2. **检查系统更新**
   - 确保 Debian 11 处于最新状态：
     ```bash
     sudo apt update && sudo apt upgrade -y
     sudo apt full-upgrade -y
     sudo apt autoremove --purge -y
     ```

3. **检查系统版本**
   - 确保当前运行的是 Debian 11：
     ```bash
     lsb_release -a
     cat /etc/debian_version
     ```

4. **检查 `/boot` 空间**
   - 升级过程中会下载新的内核，确保 `/boot` 目录有足够空间：
     ```bash
     df -h /boot
     ```

5. **禁用第三方源**
   - 如果 `/etc/apt/sources.list.d/` 目录下有非官方源，建议先禁用。

6. **切换到 root 用户**
   ```bash
   sudo -i
   ```

---

## **修改 APT 源**
1. 备份当前 APT 源：
   ```bash
   cp /etc/apt/sources.list /etc/apt/sources.list.bak
   ```

2. 修改 `/etc/apt/sources.list`，将 `bullseye` 替换为 `bookworm`：
   ```bash
   sed -i 's/bullseye/bookworm/g' /etc/apt/sources.list
   ```

3. **推荐的 Debian 12 官方源配置**：
   ```bash
   cat <<EOF > /etc/apt/sources.list
   deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
   deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
   deb http://deb.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
   EOF
   ```

4. 更新 APT 索引：
   ```bash
   apt update
   ```

---

## **升级系统**
### **1. 进行最小升级**
```bash
apt upgrade --without-new-pkgs -y
```

### **2. 进行完整升级**
```bash
apt full-upgrade -y
```

### **3. 清理不需要的软件**
```bash
apt autoremove --purge -y
```

---

## **重启并验证**
### **1. 重启系统**
```bash
reboot
```

### **2. 检查 Debian 版本**
```bash
lsb_release -a
cat /etc/debian_version
```

### **3. 确保所有服务正常运行**
```bash
systemctl --failed
```

---

## **问题排查**
1. **如果系统无法启动，可以尝试进入恢复模式**
   - 在 Grub 引导菜单中选择 `Advanced options for Debian` > `Recovery mode`，然后修复。

2. **如果 APT 依赖问题，可尝试以下命令**
   ```bash
   apt --fix-broken install
   apt -f install
   ```

3. **如果网络异常，检查 `resolv.conf`**
   ```bash
   cat /etc/resolv.conf
   ```

---

### **升级完成后建议**
- 运行 `dpkg --audit` 以检查是否有未完全安装的软件包。
- 运行 `journalctl -p 3 -xb` 以检查是否有严重错误日志。
- 备份 `/etc/apt/sources.list` 以便后续维护。

---

这样，你的 Debian 11 就成功升级到了 Debian 12！
