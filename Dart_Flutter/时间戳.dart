int 毫秒时间戳 = new DateTime.now().millisecondsSinceEpoch
int 微秒时间戳 = new DateTime.now().microsecondsSinceEpoch

// 1、Dart Flutter中获取当前时间
main(List<String> arguments) {
  //创建时间对象，获取当前时间
  DateTime now = new DateTime.now();
  print("当前时间：$now");
}

// 2、flutter dart 获取当前时间戳
static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
}
  
// 3、flutter dart 获取年月日时分秒
DateTime today = new DateTime.now();
String dateSlug ="${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";
print(dateSlug);

// http://bbs.itying.com/topic/606273354fda201694954d50