mm := make(map[string]interface{})
mm["a"] = 1
mm["b"] = "a"
// println(mm)
for name, score := range mm {
	fmt.Println(name, score)
}