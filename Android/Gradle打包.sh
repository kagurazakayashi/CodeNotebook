# React Native

# 你可以用keytool命令生成一个私有密钥。在 Windows 上keytool命令放在 JDK 的 bin 目录中（比如C:\Program Files\Java\jdkx.x.x_x\bin）
keytool -genkeypair -v -keystore my-release-key.keystore -alias my-key-alias -keyalg RSA -keysize 2048 -validity 10000
# 这条命令会要求你输入密钥库（keystore）和对应密钥的密码，然后设置一些发行相关的信息。最后它会生成一个叫做my-release-key.keystore的密钥库文件。
# 在运行上面这条语句之后，密钥库里应该已经生成了一个单独的密钥，有效期为 10000 天。--alias 参数后面的别名是你将来为应用签名时所需要用到的，所以记得记录这个别名。
# 注意：请记得妥善地保管好你的密钥库文件，一般不要上传到版本库或者其它的地方。

# 设置 gradle 变量
# 把my-release-key.keystore文件放到你工程中的android/app文件夹下。
# 编辑~/.gradle/gradle.properties（全局配置，对所有项目有效）或是项目目录/android/gradle.properties（项目配置，只对所在项目有效）。如果没有gradle.properties文件你就自己创建一个，添加如下的代码（注意把其中的****替换为相应密码）
vim /android/gradle.properties
MYAPP_RELEASE_STORE_FILE=my-release-key.keystore
MYAPP_RELEASE_KEY_ALIAS=my-key-alias
MYAPP_RELEASE_STORE_PASSWORD=*****
MYAPP_RELEASE_KEY_PASSWORD=*****
# 上面的这些会作为 gradle 的变量，在后面的步骤中可以用来给应用签名。
# 一旦你在 Play Store 发布了你的应用，如果想修改签名，就必须用一个不同的包名来重新发布你的应用（这样也会丢失所有的下载数和评分）。所以请务必备份好你的密钥库和密码。

# 把签名配置加入到项目的 gradle 配置中
vim android/app/build.gradle
# ...
# android {
#     ...
#     defaultConfig { ... }
#     signingConfigs {
#         release {
#             if (project.hasProperty('MYAPP_RELEASE_STORE_FILE')) {
#                 storeFile file(MYAPP_RELEASE_STORE_FILE)
#                 storePassword MYAPP_RELEASE_STORE_PASSWORD
#                 keyAlias MYAPP_RELEASE_KEY_ALIAS
#                 keyPassword MYAPP_RELEASE_KEY_PASSWORD
#             }
#         }
#     }
#     buildTypes {
#         release {
#             ...
#             signingConfig signingConfigs.release
#         }
#     }
# }
# ...

# 生成发行 APK 包
cd android
./gradlew assembleRelease

# 测试应用的发行版本
react-native run-android --variant=release

# https://reactnative.cn/docs/signed-apk-android/#%E7%94%9F%E6%88%90%E5%8F%91%E8%A1%8C-apk-%E5%8C%85