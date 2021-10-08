// 判断平台：
// 导入平台Platform库就行，位置在dart:io
import 'dart:io';

if (Platform.isIOS) {
    //ios相关代码
} else if (Platform.isAndroid) {
    //android相关代码
}


// 获取更多信息： device_info 库的使用
// 添加依赖
// 在pubspec.yml中的dependencies下面新增节点
//     device_info : ^0.2.0
// flutter packages get


// android版本所有属性
  /// Android operating system version values derived from `android.os.Build.VERSION`.
  final AndroidBuildVersion version;

  /// The name of the underlying board, like "goldfish".
  final String board;

  /// The system bootloader version number.
  final String bootloader;

  /// The consumer-visible brand with which the product/hardware will be associated, if any.
  final String brand;

  /// The name of the industrial design.
  final String device;

  /// A build ID string meant for displaying to the user.
  final String display;

  /// A string that uniquely identifies this build.
  final String fingerprint;

  /// The name of the hardware (from the kernel command line or /proc).
  final String hardware;

  /// Hostname.
  final String host;

  /// Either a changelist number, or a label like "M4-rc20".
  final String id;

  /// The manufacturer of the product/hardware.
  final String manufacturer;

  /// The end-user-visible name for the end product.
  final String model;

  /// The name of the overall product.
  final String product;

  /// An ordered list of 32 bit ABIs supported by this device.
  final List<String> supported32BitAbis;

  /// An ordered list of 64 bit ABIs supported by this device.
  final List<String> supported64BitAbis;

  /// An ordered list of ABIs supported by this device.
  final List<String> supportedAbis;

  /// Comma-separated tags describing the build, like "unsigned,debug".
  final String tags;

  /// The type of build, like "user" or "eng".
  final String type;

  /// `false` if the application is running in an emulator, `true` otherwise.
  final bool isPhysicalDevice;



// ios版本所有属性
/// Device name.
  final String name;

  /// The name of the current operating system.
  final String systemName;

  /// The current operating system version.
  final String systemVersion;

  /// Device model.
  final String model;

  /// Localized name of the device model.
  final String localizedModel;

  /// Unique UUID value identifying the current device.
  final String identifierForVendor;

  /// `false` if the application is running in a simulator, `true` otherwise.
  final bool isPhysicalDevice;

  /// Operating system information derived from `sys/utsname.h`.
  final IosUtsname utsname;


// https://segmentfault.com/a/1190000014913010