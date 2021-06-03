
func listselect(liststr []string, listint []int64, msg string) (string, int64) {
	fmt.Println("\n", msg, ":")
	if liststr != nil {
		list := liststr
		for i, port := range list {
			fmt.Printf("[%d]: %v\n", i, port)
		}
		pi := -1
		var err error
		for {
			fmt.Println("选择哪个", msg, "?")
			reader := bufio.NewReader(os.Stdin)
			res, _ := reader.ReadBytes('\n')
			line := bytes.TrimRight(res, "\r\n")
			fmt.Printf("已选择%s\n", line)
			pi, err = strconv.Atoi(string(line))
			if err != nil {
				fmt.Println("输入的不是数字！", err)
			} else {
				if pi > len(list)-1 {
					fmt.Println("输入的内容不能大于", len(list)-1)
				} else {
					break
				}
			}
		}
		return list[pi], -1
	} else {
		list := listint
		for i, port := range list {
			fmt.Printf("[%d]: %v\n", i, port)
		}
		pi := -1
		var err error
		for {
			fmt.Println("选择哪个", msg, "?")
			reader := bufio.NewReader(os.Stdin)
			res, _ := reader.ReadBytes('\n')
			line := bytes.TrimRight(res, "\r\n")
			fmt.Printf("已选择%s\n", line)
			pi, err = strconv.Atoi(string(line))
			if err != nil {
				fmt.Println("输入的不是数字！", err)
			} else {
				if pi > len(list)-1 {
					fmt.Println("输入的内容不能大于", len(list)-1)
				} else {
					break
				}
			}
		}
		return "", list[pi]
	}
}