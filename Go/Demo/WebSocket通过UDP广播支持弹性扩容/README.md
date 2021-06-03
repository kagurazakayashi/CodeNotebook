# mytongdy-webSocketTEST
原帖地址：https://www.jianshu.com/p/277413742ac9

### 测试方法：
在浏览器中按[F12]调出控制台，在控制台中输入以下内容

var ws = new WebSocket("ws://127.0.0.1:8866/chat?user_id=1")
ws.onmessage = function(e){console.log(e.data)}
ws.send("{\"user_id\":2,\"data\":\"haha\"}")