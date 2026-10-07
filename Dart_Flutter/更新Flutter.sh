# 更新Flutter

# 1. 确保进入 Flutter SDK 根目录
cd flutter

# 2. 放弃本地所有对 Flutter SDK 源码的修改（防止重置受阻）
git reset --hard HEAD

# 3. 清理本地未跟踪的临时文件或残留文件
git clean -xdf

# 4. 从远程仓库获取最新的分支信息与提交历史
git fetch origin stable

# 5. 强制将本地 stable 分支重置为远程 origin/stable 的最新状态（解决 divergent branches 冲突）
git reset --hard origin/stable

# 6. 触发 Flutter 引擎下载、Dart SDK 更新及内部依赖补全
flutter upgrade

# 7. 检查升级后的 Flutter 与 Dart 版本信息（验证是否升至最新 stable）
flutter --version

# 8. 检查整体开发环境依赖状态（确认 Android Studio、VS Code、Device 等配置正常）
flutter doctor
