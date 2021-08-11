// 集合Set(无序无重复数据)

// 空集合
var letter = Set<Int>()
letter = []

// 数组字面量创建集合
var food : Set<String> = ["Milk","Coco"]

// 基本属性
// count, append, insert

// 集合遍历
for i in Set.sorted()

// 集合操作
// 交集 a ∩ b :
a.intersection(b)
// 并集 a U b :
a.union(b)
// 差集, 集合a中除去和b相同的元素:
a.subtracting(b)
// 对称差集, 集合ab同时除去a和b中的交集:
a.symmetricDifference(b)

// 包含的值是否全部相同:
// ==

// 一个集合中的所有值是否也被包含在另外一个集合中:
// isSubset(of:)

// 一个集合是否包含另一个集合中所有的值
// isSuperset(of:)

// 判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等:
// isStrictSubset(of:)
// isStrictSuperset(of:)

// 判断两个集合是否不含有相同的值（是否没有交集）:
// isDisjoint(with:)