// permission_handler
// https://pub.dev/packages/permission_handler
// https://github.com/baseflowit/flutter-permission-handler
// MIT (LICENSE)

// 添加权限提示配置
// 安卓：AndroidManifest.xml
// iOS：Info.plist

var status = await Permission.camera.status;
if (status.isDenied) {
  // 我们还没有请求许可，或者许可以前被拒绝过，但不是永久性的。
}

// 您也可以直接向权限询问其状态。isRestricted：是否受限制
if (await Permission.location.isRestricted) {
  // 操作系统限制访问，例如由于家长控制。
}

// 在 Permission 需要的时候，调用 request() 。如果它之前已经被授予，则什么也不会发生。request() 返回 Permission 的新状态。
if (await Permission.contacts.request().isGranted) {
  // 该权限以前已授予，或者用户刚刚授予。
}

// 您可以一次请求多个权限。
Map<Permission, PermissionStatus> statuses = await [
  Permission.location,
  Permission.storage,
].request();
print(statuses[Permission.location]);

// 某些权限（例如位置或加速度传感器权限）具有可启用或禁用的关联服务。
if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
  // 使用位置。
}

// 您还可以打开应用程序设置：
if (await Permission.speech.isPermanentlyDenied) {
  // 用户选择不再查看此应用的权限请求对话框。现在更改权限状态的唯一方法是让用户在系统设置中手动启用它。
  openAppSettings();
}

// 在Android上，您可以显示使用权限的理由：
bool isShown = await Permission.contacts.shouldShowRequestRationale;

// 某些权限不会显示要求用户允许或拒绝请求的权限的对话框。
// 这是因为正在检索应用程序的操作系统设置以获得相应的权限。
// 设置的状态将决定权限是granted还是denied。

// 以下权限将不显示对话框：
// 通知 Notification
// 蓝牙 Bluetooth
// 以下权限不会显示对话框，但会打开相应的设置意图，供用户更改权限状态：
// 管理外部存储 manageExternalStorage
// 系统提示窗口 systemAlertWindow
// 请求安装包 requestInstallPackages
// 访问通知策略 accessNotificationPolicy

// locationAlways许可不能直接请求，用户必须请求locationWhenInUse第一许可。通过单击“使用应用程序时允许”接受此权限，用户可以请求该locationAlways权限。这将弹出另一个权限弹出窗口，要求您Keep Only While Using或Change To Always Allow。
