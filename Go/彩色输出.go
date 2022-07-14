import (
	"os"
	"os/signal"
	"fmt"
	"github.com/logrusorgru/aurora"
)
func main() {
	sigs := make(chan os.Signal, 1)
	done := make(chan bool, 1)
	// 修改文字颜色
	fmt.Println(aurora.Magenta("Mochi MQTT Server initializing..."), aurora.Cyan("TCP"))
	// 修改背景颜色
	fmt.Println(aurora.BgMagenta("  Started!  "))
	<-done
	fmt.Println(aurora.BgRed("  Caught Signal  "))
	server.Close()
	fmt.Println(aurora.BgGreen("  Finished  "))
}