### 安装 ###

# 检查问题
flutter doctor
# 同意 Android 协议
flutter doctor --android-licenses
# 升级
flutter upgrade
# 切换 flutter 测试版
flutter channel # 输出channel
flutter channel dev # 切换到dev channel
# 预下载所有工具
flutter precache

### 创建 ###

# 创建新的flutter项目
flutter create <name>

### 运行 ###

# 运行
flutter run ios
# 运行并显示所有日志
flutter -v run
# 运行，热重载等都手动操作
flutter attach
# 列出已经连接到计算机的设备
flutter devices
# 指定设备名称运行
flutter run -d <设备名称或设备id>
# Android 模拟器
flutter emulators --launch flutter_emulator #启动
flutter emulators # 列出
flutter emulators --create Pixel_API_28 # 创建
# 单元测试
flutter test --concurrency=8 # --concurrency=8 指定并发数量
# 截图
flutter screenshot -o <截图保存文件夹>

### 包 ###

# 下载安装依赖包(依据或创建 pubspec.lock )
flutter packages get
# 更新依赖包:检索当前 Package 所依赖的其它 Package 的最新版本
flutter pub upgrade
# 更新依赖项:检索当前 Package 所依赖的其它 Package (依据或创建 pubspec.lock )
flutter pub outdated
# 清除所有缓存的 Package 并重新安装
flutter pub cache
# 显示所有的依赖
flutter pub deps
# 缓存修复
flutter pub cache repair

### 编译 ###

flutter build apk
flutter build ios # 需要 Xcode
flutter build appbundle
flutter build aot
flutter install # 安装app到一个已经连接的设备

### 分析 ###

# 分析代码
flutter analyze
# 分析代码一直运行
flutter analyze --watch
# 分析代码不要自动 pub get
flutter analyze --no-pub

### 清理 ###

# 删除`build/`和`.dart_tool/`目录,清除缓存信息,避免之前不同版本代码的影响
flutter clean

### Dart ###

dart upgrade
dart fix
dart fix --dry-run