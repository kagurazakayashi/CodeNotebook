var object interface{}


reflect.TypeOf(object).Name()


switch objectType := object.(type) {
case string:
	value, err = strconv.Atoi(objectType)
	if err != nil {
		fmt.Println("string => int:", objectType)
		continue
	}
case int64:
	value = int(objectType)
case int:
	value = objectType
}