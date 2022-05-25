// List<dynamic> 转 List<String>
List<dynamic> dynList = ["1","2","3","4","5"];
List<String> stringList = dynList.cast<int>();

// List<String> 转 List<dynamic>
List<dynamic> dynList = List<dynamic>.from(stringList);

// List<dynamic> 转 List<int>
List<dynamic> dynList = [1,2,3,4,5];
List<int> intList = dynList.cast<int>();
