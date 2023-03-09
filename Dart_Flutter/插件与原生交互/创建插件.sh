# 新建Flutter插件

flutter create --org moe.yashi --template=plugin --platforms=android,ios -i swift -a kotlin name
flutter create --org moe.yashi --template=plugin --platforms=android,ios -i objc -a java name

# plugin:
#   platforms:
#     android:
#         package: com.example.name
#         pluginClass: namePlugin
#     ios:
#       pluginClass: namePlugin


# 新建Flutter包
flutter create --org moe.yashi --template=package name