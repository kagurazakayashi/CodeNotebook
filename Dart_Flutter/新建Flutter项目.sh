# ============================================================
# 新建Flutter项目.sh
# 用法: flutter create [选项] <输出目录>
# ============================================================

# --- 快捷参数 ---
# -h, --help              打印帮助信息
# -v, --verbose            详细日志输出
# -t, --template=<type>    指定项目类型模板
# -a, --android-language   安卓开发语言 (java | kotlin)
# -i, --ios-language       iOS 开发语言 (objc | swift)
# -e, --[no-]empty         创建极简模板（不含注释），隐含 --template=app

# --- 模板类型 --template ---
# [app]           (默认) 生成 Flutter 应用程序
# [module]        生成 Flutter 模块，可嵌入到现有 Android/iOS 原生应用
# [package]       生成纯 Dart 代码的可共享包
# [package_ffi]   生成 Dart + dart:ffi 原生实现的包（推荐，取代 plugin_ffi）
# [plugin]        生成通过方法通道(Method Channel)实现原生的插件
# [plugin_ffi]    (已弃用) 通过 dart:ffi 实现原生的插件，请改用 package_ffi
# [skeleton]      (已弃用) 旧版列表/详情视图模板

# --- 平台选项 --platforms ---
# 仅在 --template=app 或 plugin 时生效
# 可选值: ios, android, windows, linux, macos, web
# 默认全部启用

# --- 项目描述 ---
# --description       项目描述（默认 "A new Flutter project."），写入 pubspec.yaml
# --org               组织标识，反向域名格式（默认 "com.example"）
# --project-name      项目名称，必须是合法的 Dart 包名

# --- 行为控制 ---
# --[no-]pub          是否创建后运行 "flutter pub get"（默认 on）
# --[no-]offline      pub get 时使用离线模式（默认 off）
# --[no-]overwrite    是否覆盖已存在的文件（默认 off，可用于修复项目）

# ============================================================
# 示例
# ============================================================

# 1. 创建一个全平台 Flutter 应用
flutter create my_app

# 2. 创建仅安卓+iOS 的应用，使用 Swift 和 Kotlin
flutter create --platforms=android,ios -i swift -a kotlin my_app

# 3. 创建时指定组织域名和项目名称
flutter create --org com.mycompany --project-name my_app my_app

# 4. 创建极简模板（空 main.dart，无注释）
flutter create -e my_app

# 5. 创建纯 Dart 包（无平台代码）
flutter create -t package my_package

# 6. 创建 FFI 插件包
flutter create -t package_ffi my_ffi_plugin

# 7. 创建方法通道插件，仅支持 Android 和 iOS
flutter create -t plugin --platforms=android,ios my_plugin

# 8. 创建 Flutter 模块（用于嵌入原生应用）
flutter create -t module my_flutter_module

# 9. 创建时跳过 pub get（离线或网络受限时）
flutter create --no-pub my_app

# 10. 创建 macOS 桌面应用（需先启用桌面支持）
#     flutter config --enable-macos-desktop
flutter create --platforms=macos my_macos_app

# 11. 修复/重建已有项目（覆盖缺失文件）
flutter create --overwrite .

# 12. 带自定义描述创建
flutter create --description "我的 Flutter 应用" my_app

# 13. 全功能演示（启用所有参数）
flutter create -v -t app --platforms=android,ios,windows,linux,macos,web -a kotlin -i swift --org com.example --project-name my_full_app --description "全功能演示项目" --pub my_full_app

# 14. 在已克隆的空仓库目录中创建项目（输出目录设为当前目录 .）
CD my_empty_repo
flutter create --org com.example --project-name my_app .
# 注意：如果报错"目录非空"（如已有 .git README 等），加 --overwrite 覆盖
flutter create --overwrite --org com.example --project-name my_app .
