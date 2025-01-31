# Android Gradle 决定需要使用的JDK版本

## 1. build.gradle

```txt
查看 classpath("com.android.tools.build:gradle:7.3.0")
                                               ^ ^ ^
https://developer.android.com/build/releases/past-releases/agp-7-3-0-release-notes?hl=zh-cn
                                                               ^ ^ ^
```

## 2. 看兼容性

|     | 最低版本 | 默认版本 | 备注  |
| --- | --- | --- | --- |
| Gradle | 7.4 | **7.4** | ... |

## 3. 找 7.4 Gradle 对应 Java version

去 https://docs.gradle.org/current/userguide/compatibility.html 

Table 1. Java Compatibility

| Java version | Support for toolchains | Support for running Gradle |
| --- | --- | --- |
| 16  | 7.0 | 7.0 |
| 17  | 7.3 | 7.3 |
| 18  | 7.5 | 7.5 |
| 19  | 7.6 | 7.6 |

看 **Support for running Gradle** , 注意越往下版本越高。

你使用的是 **Gradle 7.4**，那么对于 Java 版本的选择，根据 Gradle 官方文档和版本兼容性，推荐如下：

- **Gradle 7.4** 是兼容 **Java 17** 的。  
  Gradle 7.4 支持的最低 Java 版本是 Java 8，但它也支持 Java 17。

- **Java 18** 是支持 Gradle 7.5 及以上版本的，因此它不适用于 Gradle 7.4。

综上所述，如果你正在使用 Gradle 7.4，应该选择 **Java 17**。这样可以确保与 Gradle 7.4 的兼容性。

## 4. 修改本地 gradle 的 gradle.properties

`org.gradle.java.home=C:\\Program Files\\Microsoft\\jdk-17.0.13.11-hotspot`
