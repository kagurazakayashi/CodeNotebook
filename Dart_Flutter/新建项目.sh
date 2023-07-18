# 创建新的flutter项目
flutter create --platforms=android,ios --ios-language swift --android-language kotlin --org moe.yashi name

# --platforms = [ios (default), android (default), windows (default), linux (default), macos (default), web (default)]
# --ios-language = [objc, swift (default)]
# --android-language = [java, kotlin (default)]
# --template = [app  (default), module, package, plugin, plugin_ffi, skeleton]
# [app]        （默认）生成 Flutter 应用程序。
# [module]     生成一个项目以将 Flutter 模块添加到现有 Android 或 iOS 应用程序。
# [package]    生成包含模块化 Dart 代码的可共享 Flutter 项目。
# [plugin]     通过适用于 Android、iOS、Linux、macOS、Windows、Web 或这些平台的任意组合的方法通道，生成一个可共享的 Flutter 项目，其中包含 Dart 代码中的 API，并具有特定于平台的实现。
# [plugin_ffi] 通过适用于 Android、iOS、Linux、macOS、Windows 或这些平台的任意组合的 dart:ffi，生成一个包含 Dart 代码中的 API 的可共享 Flutter 项目，以及特定于平台的实现。
# [skeleton]   生成遵循社区最佳实践的列表视图/详细信息视图 Flutter 应用程序。
