// go运行程序 同步方式
func subscribeRestart(w http.ResponseWriter, idKey string) []byte {
	var cmd *exec.Cmd = exec.Command("docker", "restart", "subscribe")
	var err error = cmd.Run()
	if err != nil {
		fmt.Println("执行命令失败:", err.Error())
	}
}
