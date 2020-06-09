// Map 初始化
Map<String, String> map = new HashMap<String, String>();

// 插入元素
map.put("key1", "value1");

// 获取元素
map.get("key1");

// 移除元素
map.remove("key1");

// 清空map
map.clear();

// Map 遍历：增强for循环遍历

// 使用keySet()遍历
for (String key : map.keySet()) {
    System.out.println(key + " ：" + map.get(key));
}

// 使用entrySet()遍历
for (Map.Entry<String, String> entry : map.entrySet()) {
    System.out.println(entry.getKey() + " ：" + entry.getValue());
}

// Map 遍历：迭代器遍历

// 使用keySet()遍历
Iterator<String> iterator = map.keySet().iterator();
while (iterator.hasNext()) {
    String key = iterator.next();
    System.out.println(key + "　：" + map.get(key));
}

// 使用entrySet()遍历（快）
Iterator<Map.Entry<String, String>> iterator = map.entrySet().iterator();
while (iterator.hasNext()) {
    Map.Entry<String, String> entry = iterator.next();
    System.out.println(entry.getKey() + "　：" + entry.getValue());
}

// TreeMap 排序
Map<String, String> map = new HashMap<String, String>();
map.put("a", "c");
map.put("b", "b");
map.put("c", "a");
// 通过ArrayList构造函数把map.entrySet()转换成list
List<Map.Entry<String, String>> list = new ArrayList<Map.Entry<String, String>>(map.entrySet());
// 通过比较器实现比较排序
Collections.sort(list, new Comparator<Map.Entry<String, String>>() {
    public int compare(Map.Entry<String, String> mapping1, Map.Entry<String, String> mapping2) {
        return mapping1.getKey().compareTo(mapping2.getKey());
    }
});
 
for (Map.Entry<String, String> mapping : list) {
    System.out.println(mapping.getKey() + " ：" + mapping.getValue());
}

// TreeMap排序：比较器
// TreeMap默认按key进行升序排序，如果想改变默认的顺序，可以使用比较器:
Map<String, String> map = new TreeMap<String, String>(new Comparator<String>() {
    public int compare(String obj1, String obj2) {
        return obj2.compareTo(obj1);// 降序排序
    }
});
map.put("a", "c");
map.put("b", "b");
map.put("c", "a");
for (String key : map.keySet()) {
    System.out.println(key + " ：" + map.get(key));
}

// 按value排序(通用)
Map<String, String> map = new TreeMap<String, String>();
map.put("a", "c");
map.put("b", "b");
map.put("c", "a");

// 通过ArrayList构造函数把map.entrySet()转换成list
List<Map.Entry<String, String>> list = new ArrayList<Map.Entry<String, String>>(map.entrySet());
// 通过比较器实现比较排序
Collections.sort(list, new Comparator<Map.Entry<String, String>>() {
    public int compare(Map.Entry<String, String> mapping1, Map.Entry<String, String> mapping2) {
        return mapping1.getValue().compareTo(mapping2.getValue());
    }
});

for (String key : map.keySet()) {
    System.out.println(key + " ：" + map.get(key));
}

// 常用API
// clear()	从 Map 中删除所有映射
// remove(Object key)	从 Map 中删除键和关联的值
// put(Object key, Object value)	将指定值与指定键相关联
// putAll(Map t)	将指定 Map 中的所有映射复制到此 map
// entrySet()	返回 Map 中所包含映射的 Set 视图。Set 中的每个元素都是一个 Map.Entry 对象，可以使用 getKey() 和 getValue() 方法（还有一个 setValue() 方法）访问后者的键元素和值元素
// keySet()	返回 Map 中所包含键的 Set 视图。删除 Set 中的元素还将删除 Map 中相应的映射（键和值）
// values()	返回 map 中所包含值的 Collection 视图。删除 Collection 中的元素还将删除 Map 中相应的映射（键和值）
// get(Object key)	返回与指定键关联的值
// containsKey(Object key)	如果 Map 包含指定键的映射，则返回 true
// containsValue(Object value)	如果此 Map 将一个或多个键映射到指定值，则返回 true
// isEmpty()	如果 Map 不包含键-值映射，则返回 true
// size()	返回 Map 中的键-值映射的数目

// https://www.cnblogs.com/lzq198754/p/5780165.html