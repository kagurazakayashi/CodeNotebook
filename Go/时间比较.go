//时间比较
var formatDateHM string = "2006-01-02 15:04"
tn :=time.Now()
tf := tn.Format(formatDateHM)
tfs := strings.Split(tf, " ")
tf1 := ""
tf2 := ""
if len(tfs) > 1 {
	tfs[1] = ft1.String()
	tf1 = strings.Join(tfs, " ")
	tfs[1] = ft2.String()
	tf2 = strings.Join(tfs, " ")
}
tf1Time, err := time.ParseInLocation(formatDateHM, tf1, cst)
if err != nil {
	fmt.Println(err)
	return
}
tf2Time, err := time.ParseInLocation(formatDateHM, tf2, cst)
if err != nil {
	fmt.Println(err)
	return
}
if !tf1Time.Before(tf2Time) {
day, err := time.ParseDuration("24h")
if err == nil {
	tf2Time = tf2Time.Add(day)
	// fmt.Println("!!!", tf2Time)
}
tnCST := tn.UTC().In(cst)
fmt.Println(tf1Time, tnCST, tf2Time)
if !(tf1Time.Before(tnCST) && tnCST.Before(tf2Time)) {
	if isAlter {
		isAlters[i] = true
	}
	if isOffLine {
		isOffLines[i] = true
	}
	if (newans[i] != 0 && newans[i]%aes[i] == 0) || (newons[i] != 0 && newons[i]%aes[i] == 0) {
		isSends[i] = true
	}
}