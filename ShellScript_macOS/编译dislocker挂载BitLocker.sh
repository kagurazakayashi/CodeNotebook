# 安装 macFUSE 
# 如果是 Apple Silicon (M1-M4) 芯片，必须在 Recovery 模式开启“降低安全性”并勾选允许内核扩展。
brew install --cask macfuse

# 安装开发工具和库: dislocker 依赖 mbedtls 处理加密，依赖 cmake 构建项目。
brew install cmake mbedtls pkg-config

# 克隆
git clone https://github.com/Aorimn/dislocker.git
cd dislocker

# 由于 2026 年的 CMake 不再支持极旧的版本，我们需要手动改一下。
vim src/CMakeLists.txt
# 找 find_package (MbedTLS 3 REQUIRED)
# 去掉3: find_package(MbedTLS REQUIRED)

# MbedTLS 4.0 移除了大量 3.x 時代的舊接口，安裝舊版本：
brew install mbedtls@3

# 创建构建目录
mkdir build && cd build

# 验证依赖路径
ls /usr/local/opt/mbedtls@3
ls /usr/local/include
ls /usr/local/lib/libfuse.dylib

# 清理缓存
rm -rf *

# 重新配置
cmake .. \
  -DCMAKE_C_FLAGS="-Wno-error=incompatible-function-pointer-types" \
  -DCMAKE_PREFIX_PATH="/usr/local/opt/mbedtls@3" \
  -DCMAKE_POLICY_VERSION_MINIMUM=3.10 \
  -DFUSE_INCLUDE_DIR=/usr/local/include \
  -DFUSE_LIBRARY=/usr/local/lib/libfuse.dylib
# 看到 -- Generating done 和 Build files have been written 就意味著 OK , 开始编译：
make
sudo make install

# 使用

# 如果運行 dislocker 報錯 Library not loaded：
export DYLD_LIBRARY_PATH=/usr/local/lib:$DYLD_LIBRARY_PATH

# 首先要找到你的 BitLocker 分區在系統裡的編號。在輸出列表中，尋找類型為 Microsoft Basic Data 的分區。記住它的 IDENTIFIER（例如 disk4s1）。
diskutil list

# 我們需要一個地方來存放解密後的虛擬鏡像（這不會佔用實際硬碟空間，只是內存映射）。
# 創建一個解密掛載點：
sudo mkdir -p /Volumes/BitLocker_Raw

# 使用密碼解锁
# 將 diskXsY 換成你剛才查到的編號，如 disk6s3
sudo dislocker -V /dev/disk6s3 -u -- /Volumes/BitLocker_Raw -o allow_other
# 前台调试模式
sudo dislocker -v -V /dev/disk6s3 -u -- /Volumes/BitLocker_Raw -f -o allow_other
# 使用恢复密钥解锁
sudo dislocker -V /dev/disk6s3 -p恢复密钥 -- /Volumes/BitLocker_Raw

# 將虛擬文件掛載到 macOS
# 創建最終掛載點：
sudo mkdir -p /Volumes/BitLocker_Data
# 掛載鏡像：
sudo mount -t exfat /Volumes/BitLocker_Raw/dislocker-file /Volumes/BitLocker_Data

# 取消挂载
# 1. 卸載數據分區
sudo umount /Volumes/BitLocker_Data
# 2. 卸載解密虛擬點
sudo umount /Volumes/BitLocker_Raw
sudo pkill -9 dislocker
