// import 'dart:ffi';

typedef GetObject = Function(dynamic object);

class EasyLinkNotification {
  // 工厂模式
  factory EasyLinkNotification() => _getInstance();

  static EasyLinkNotification get instance => _getInstance();
  static EasyLinkNotification _instance;

  // ignore: sort_constructors_first
  EasyLinkNotification._internal() {
    // 初始化
  }

  static EasyLinkNotification _getInstance() {
    _instance ??= EasyLinkNotification._internal();
    return _instance;
  }

  //创建Map来记录名称
  // ignore: prefer_collection_literals
  Map<String, dynamic> postNameMap = Map<String, dynamic>();

  GetObject getObject;

  //添加监听者方法
  void addObserver(String postName, object(dynamic object)) {
    postNameMap[postName] = null;
    getObject = object;
  }

  //发送通知传值
  void postNotification(String postName, dynamic object) {
    //检索Map是否含有postName
    if (postNameMap.containsKey(postName)) {

      postNameMap[postName] = object;
      getObject(postNameMap[postName]);
    }

  }
  //移除通知
  void removeNotification(String postName) {
     if (postNameMap.containsKey(postName)) {

        postNameMap.remove(postName);
     }
  }
}