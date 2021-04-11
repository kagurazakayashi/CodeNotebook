package main

import (
	"strings"

	"github.com/tidwall/gjson"
)

const json = `{"登录信息":{"用户名":"雅诗","密码":"这是密码"},"数组信息A":["你好","世界"],"数组信息B":["测试","信息"],"编.号":2333,"好友":[{"名字":"miyabi","年龄":18,"语言":["en","US"]},{"名字":"小雅诗","年龄":12,"语言":["zh","CN"]}]}`

/*
{
    "登录信息": {
        "用户名": "雅诗",
        "密码": "这是密码"
    },
    "数组信息A": [
        "你好",
        "世界"
    ],
    "数组信息B": [
        "测试",
        "信息"
    ],
    "编.号": 2333,
    "好友": [
        {
            "名字": "miyabi",
            "年龄": 18,
            "地址": [
                "en",
                "US"
            ]
        },
        {
            "名字": "小雅诗",
            "年龄": 12,
            "地址": [
                "zh",
                "CN"
            ]
        }
    ]
}
*/

func main() {
	result := gjson.Get(json, "登录信息.密码")
	println(result.String())
	// 这是密码

	result = gjson.Get(json, "登录信息") // 取 Key 的值
	println(result.String())
	// {"用户名":"雅诗","密码":"这是密码"}

	result = gjson.Get(json, "数组信息A") // 取 Key 的值
	println(result.String())
	// ["你好","世界"]

	result = gjson.Get(json, "数组信息A.#") // 统计数组长度
	println(result.String())
	// 2

	result = gjson.Get(json, "数组信息A.0") // 取第 0 个值
	println(result.String())
	// 你好

	result = gjson.Get(json, "数组信息B.1") // 取第 1 个值
	println(result.String())
	// 信息

	result = gjson.Get(json, "数组*") // *通配符，寻找第一个符合条件的
	println(result.String())
	// ["你好","世界"]

	result = gjson.Get(json, "数组*.1") // *通配符，寻找第一个符合条件的取第 1 个值
	println(result.String())
	// 世界

	result = gjson.Get(json, "数?信息A.0") // 单字?通配符
	println(result.String())
	// 你好

	result = gjson.Get(json, "编\\.号") // 将.转义
	println(result.String())
	// 2333

	result = gjson.Get(json, "好友.#(名字==\"小雅诗\")") // 按条件搜索字典组成的数组
	println(result.String())
	// {"名字":"小雅诗","年龄":12,"语言":["zh","CN"]}

	result = gjson.Get(json, "好友.#(名字==\"小雅诗\").年龄") // 按条件搜索字典组成的数组中的对象
	println(result.Int())
	// 12

	result = gjson.Get(json, "好友.#(年龄<20)#") // 按条件搜索字典组成的数组
	println(result.String())
	// [{"名字":"miyabi","年龄":18,"语言":["en","US"]},{"名字":"小雅诗","年龄":12,"语言":["zh","CN"]}]

	result = gjson.Get(json, "好友.#(年龄<20)#.名字") // 按条件搜索字典组成的数组中的对象
	println(result.String())
	// ["miyabi","小雅诗"]

	result = gjson.Get(json, "好友.#(名字%\"小*\")") // 类似于
	println(result.String())
	// {"名字":"小雅诗","年龄":12,"语言":["zh","CN"]}

	result = gjson.Get(json, "好友.#(名字!%\"小*\")") // 不类似于
	println(result.String())
	// {"名字":"miyabi","年龄":18,"语言":["en","US"]}

	result = gjson.Get(json, "好友.#(语言.#(==\"zh\"))#") // 多条件查询，查找 zh 的所有匹配
	println(result.String())
	// [{"名字":"小雅诗","年龄":12,"语言":["zh","CN"]}]

	result = gjson.Get(json, "好友.#(语言.#(==\"zh\")).语言.1") // #(…) 查询第一个匹配的数组
	println(result.String())
	// CN

	result = gjson.Get(json, "好友.#(语言.#(==\"zh\"))#.语言.1") // #(…)# 查找所有匹配
	println(result.String())
	// ["CN"]

	/*
		输出 String 以外类型
		result.Exists()           bool
		result.Value()            interface{}
		result.Int()              int64
		result.Uint()             uint64
		result.Float()            float64
		result.String()           string
		result.Bool()             bool
		result.Time()             time.Time
		result.Array()            []gjson.Result
		result.Map()              map[string]gjson.Result
		result.Get(path string)   Result
	*/

	result = gjson.Get(json, "好友.#(名字==\"小雅诗\")")
	println(result.String())
	// {"名字":"小雅诗","年龄":12,"语言":["zh","CN"]}

	// 遍历结果：
	result.ForEach(func(key, value gjson.Result) bool {
		println(key.String() + " -> " + value.String())
		// 名字 -> 小雅诗
		// 年龄 -> 12
		// 语言 -> ["zh","CN"]
		return true // keep iterating
	})

	// 判断返回值类型：
	println(result.Type.String())
	// JSON
	// 还可以是 String, Number, True, False, Null

	// 修饰符函数和路径链接：

	result = gjson.Get(json, "登录信息|@reverse") // 反转数组
	println(result.String())
	// {"密码":"这是密码","用户名":"雅诗"}

	result = gjson.Get(json, "登录信息|@reverse|用户名")
	println(result.String())
	// 雅诗

	/*
		@reverse: 反转数组或对象的成员。
		@ugly:    删除json中的所有空白。
		@pretty:  使json更具可读性。
		@this:    返回当前元素。它可以用来检索根元素。
		@valid:   确保json有效。
		@flatten: 平滑数组。
		@join:    将多个对象连接到单个对象。
		自定义转换方法:
	*/
	gjson.AddModifier("case", func(json, arg string) string {
		if arg == "upper" {
			return strings.ToUpper(json)
		}
		if arg == "lower" {
			return strings.ToLower(json)
		}
		return json
	})
	result = gjson.Get(json, "好友.0.名字|@case:upper")
	println(result.String()) // MIYABI
	result = gjson.Get(json, "好友.0.名字|@case:lower")
	println(result.String()) // miyabi

	// JSON Lines -> https://github.com/tidwall/gjson#json-lines

	// 遍历

	// 遍历嵌套数组中某个Key的值
	result = gjson.Get(json, "好友.#.名字")
	for _, name := range result.Array() {
		println(name.String())
	}
	// miyabi
	// 小雅诗

	// 遍历对象或数组
	result = gjson.Get(json, "好友")
	result.ForEach(func(key, value gjson.Result) bool {
		println(value.String())
		return true // keep iterating
	})
	// {"名字":"miyabi","年龄":18,"语言":["en","US"]}
	// {"名字":"小雅诗","年龄":12,"语言":["zh","CN"]}

	// 检查某个值是否存在
	result = gjson.Get(json, "职位")
	if !result.Exists() {
		println("没有此项")
	}
	// 没有此项

	// 检查某个值是否存在（简化）
	if gjson.Get(json, "好友").Exists() {
		println("包含此项")
	}
	// 包含此项

	// 验证 JSON
	if !gjson.Valid(json) {
		println("解析失败！")
	} else {
		println("解析成功。")
	}
	// 解析成功。

	// 转换为 map
	m, ok := gjson.Parse(json).Value().(map[string]interface{})
	if !ok {
		// 不是 map
	}
	println(m)

	// 一次获取多个返回值
	results := gjson.GetMany(json, "数组信息A.0", "数组信息B.1", "好友.0.名字")
	for _, result := range results {
		println(result.String())
	}
	// 你好
	// 信息
	// miyabi

	// 不存在的值
	result = gjson.Get(json, "不存在的值")
	if result.String() == "" {
		println("不存在的值！")
	}
	// 不存在的值！

	/*
		简化写法，以下作用等同：
		gjson.Parse(json).Get("name").Get("last")
		gjson.Get(json, "name").Get("last")
		gjson.Get(json, "name.last")
	*/

	// 未明确用法
	// result.Less(token Result, caseSensitive bool) bool
}

// 参考 https://github.com/tidwall/gjson