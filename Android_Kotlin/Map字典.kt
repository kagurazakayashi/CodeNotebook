// TreeMap 是排序的
// HashMap 不是排序的

import java.util.*

var map = TreeMap<String, Int>()
map["A"] = 1
map["B"] = 2

println(map["B"])

// 不定类型的 Map
HashMap<Object,Object> map = new HashMap<Object,Object>();
map.put(1, "三国"); // 值是字符串
map.put("数组", new int[]{1,2,3}); // 值是数组
map.put(null, null); // 值是null
map.put(map, map); // 值是map自己
map.put('A', 2.8); // 值是浮点数
// 遍历不定类型的 Map
Iterator<Entry<Object,Object>> it = map.entrySet().iterator();
while(it.hasNext()){
    Entry<Object,Object> e = it.next();
    System.out.println(e.getKey()+","+e.getValue());
}