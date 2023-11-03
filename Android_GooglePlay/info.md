# key:
## 生成:
```
keytool -genkey -v -keystore "D:\upload-keystore.jks" -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
```
keytool -importkeystore -srckeystore "D:\object\Android Key\upload-keystore.jks" -destkeystore "D:\object\Android Key\upload-keystore.jks" -deststoretype pkcs12
```
## 配置:
### key.properties
- path:
```
android\key.properties
```
### build.gradle
- path:
```
android\app\build.gradle
```
#### 引入keystore: 
1. `在android块前添加`
```
    def keystoreProperties = new Properties()
    def keystorePropertiesFile = rootProject.file('key.properties')
    if (keystorePropertiesFile.exists()) {
        keystoreProperties.load(new FileInputStream (keystorePropertiesFile))
    }
    android {
         ...
    }
```
2. `找到 buildTypes 块：`
```
   buildTypes {
       release {
           // TODO: Add your own signing config for the release build.
           // Signing with the debug keys for now,
           // so `flutter run --release` works.
           signingConfig signingConfigs.debug
       }
   }
```
并将其替换为以下签名配置信息：
```
   signingConfigs {
       release {
           keyAlias keystoreProperties['keyAlias']
           keyPassword keystoreProperties['keyPassword']
           storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
           storePassword keystoreProperties['storePassword']
       }
   }
   buildTypes {
       release {
           signingConfig signingConfigs.release
       }
   }
```

# 混淆:
## 配置混淆:
### proguard-rules.pro
- path:
```
android\app\proguard-rules.pro
```
## R8开关:
### gradle.properties
- path:
```
android\gradle.properties
```
### build.gradle
- path:
```
android\app\build.gradle
```
#### 开启混淆：
在`android.buildTypes.release`中添加:
```
android {
    ...
    buildTypes {
        release {
            ...
            shrinkResources true   // 开启混淆
            minifyEnabled true     // 开启混淆
            proguardFiles getDefaultProguardFile(
                    'proguard-android-optimize.txt'),
                    'proguard-rules.pro'
            ndk {
                debugSymbolLevel 'FULL' //'SYMBOL_TABLE'
            }
        }
    }
    ...
}
```
- 注意：原生代码调试符号文件的大小上限为 `300 MB`。如果调试符号占用空间过大，请使用 `SYMBOL_TABLE` 而不是 `FULL` 缩减文件大小。
#### 只保留需要的多语言资源
在`android.defaultConfig`中添加:
```
android {
    ...
    defaultConfig {
        ...
        resConfigs "en", "zh", "es"
    }
}
```

# 编译 *.aab
flutter build appbundle

# 原生调试符号文件
- 使用`flutter build appbundle`打包完成后，进入目录:
```
build\app\intermediates\merged_native_libs\release\out\lib
```
将目录中的所有文件夹打包成zip文件
```
7z a -tzip -mx9 lib.zip build\app\intermediates\merged_native_libs\release\out\lib\*
```
