/// Flutter判断对象类型 输出对象类型: runtimeType
String getType(dynamic obj) {
  Type objType = obj.runtimeType;
  switch (objType) {
    case int: {
      return "int";
    }
  }
  return "";
}
