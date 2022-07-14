//Golang
import (
	"net/http"
	_ "net/http/pprof"
)

func main(){
	go http.ListenAndServe(":9999", nil)
}


//web
访问 http://127.0.0.1:9999/debug/pprof/

//终端
go tool pprof -inuse_space http://127.0.0.1:9999/debug/pprof/heap

//pprof
top //内存用量排序
(pprof) top
Showing nodes accounting for 5801.11kB, 100% of 5801.11kB total
Showing top 10 nodes out of 33
      flat  flat%   sum%        cum   cum%
 2562.50kB 44.17% 44.17%  2562.50kB 44.17%  runtime.allocm
 1165.27kB 20.09% 64.26%  1165.27kB 20.09%  main.getNetConn
  526.13kB  9.07% 73.33%  1048.83kB 18.08%  github.com/xuri/excelize/v2.init
  522.70kB  9.01% 82.34%   522.70kB  9.01%  regexp/syntax.(*compiler).inst (inline)
  512.31kB  8.83% 91.17%   512.31kB  8.83%  net.newFD (inline)
  512.20kB  8.83%   100%   512.20kB  8.83%  runtime.malg
         0     0%   100%   512.31kB  8.83%  main.main
         0     0%   100%   512.31kB  8.83%  net.(*ListenConfig).Listen
         0     0%   100%   512.31kB  8.83%  net.(*sysListener).listenTCP
         0     0%   100%   512.31kB  8.83%  net.Listen

list xx //列出所选的变量名
(pprof) list runtime.allocm
Total: 5.67MB
ROUTINE ======================== runtime.allocm in D:\sdk\go\src\runtime\proc.go
    2.50MB     2.50MB (flat, cum) 44.17% of Total
         .          .   1738:           }
         .          .   1739:           sched.freem = newList
         .          .   1740:           unlock(&sched.lock)
         .          .   1741:   }
         .          .   1742:
    2.50MB     2.50MB   1743:   mp := new(m)
         .          .   1744:   mp.mstartfn = fn
         .          .   1745:   mcommoninit(mp, id)
         .          .   1746:
         .          .   1747:   // In case of cgo or Solaris or illumos or Darwin, pthread_create will make us a stack.
         .          .   1748:   // Windows and Plan 9 will layout sched stack on OS stack.