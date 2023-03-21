typedef GetObject = Function(dynamic object);

class NotificationCenter {
  // 工厂模式
  factory NotificationCenter() => _getInstance();

  static NotificationCenter get instance => _getInstance();
  static NotificationCenter? _instance;

  NotificationCenter._internal() {
    // 初始化
  }

  static NotificationCenter _getInstance() {
    _instance ??= NotificationCenter._internal();
    return _instance!;
  }

  //创建Map来记录名称

  Map<String, dynamic> postNameMap = <String, dynamic>{};

  Map<String, GetObject> getObject = <String, GetObject>{};

  //添加监听者方法
  addObserver(String postName, Function(dynamic object) object) {
    postNameMap[postName] = null;
    getObject[postName] = object;
  }

  //发送通知传值
  postNotification(String postName, dynamic object) {
    //检索Map是否含有postName
    if (postNameMap.containsKey(postName)) {
      postNameMap[postName] = object;
      getObject[postName]!(postNameMap[postName]);
    }
  }

  //移除通知
  removeNotification(String postName) {
    if (postNameMap.containsKey(postName)) {
      postNameMap.remove(postName);
    }
  }
}
