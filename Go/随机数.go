//随机数

rand.Seed(time.Now().UnixNano())
fmt.Println(rand.Intn(100))