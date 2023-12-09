# CSP可以由两种方式指定： HTTP Header 和 HTML。

## 通过定义在HTTP header 中使用

```yaml
Content-Security-Policy: "策略集"
```

## 通过定义在 HTML meta标签中使用：

```html
<meta http-equiv="content-security-policy" content="策略集">
```

# 格式

```yaml
Content-Security-Policy: 指令1 指令值1
Content-Security-Policy: 指令1 指令值1；指令2 指令值2；指令3 指令值3
Content-Security-Policy: 指令a 指令值a1 指令值a2
```

## 指令

- `default-src` : 定义针对所有类型（js/image/css/font/ajax/iframe/多媒体等）资源的默认加载策略，如果某类型资源没有单独定义策略，就使用默认的。
- `script-src` : 定义针对 JavaScript 的加载策略。
- `style-src` : 定义针对样式的加载策略。
- `img-src` : 定义针对图片的加载策略。
- `font-src` : 定义针对字体的加载策略。
- `media-src` : 定义针对多媒体的加载策略，例如:音频标签和视频标签。
- `object-src` : 定义针对插件的加载策略。
- `child-src` :定义针对框架的加载策略。
- `connect-src` : 定义针对 Ajax/WebSocket 等请求的加载策略。不允许的情况下，浏览器会模拟一个状态为400的响应。
- `sandbox` : 定义针对 sandbox 的限制，相当于 的sandbox属性。
- `report-uri` : 告诉浏览器如果请求的资源不被策略允许时，往哪个地址提交日志信息。
- `form-action` : 定义针对提交的 form 到特定来源的加载策略。
- `referrer` : 定义针对 referrer 的加载策略。
- `reflected-xss` : 定义针对 XSS 过滤器使用策略。

## 指令值

- `*` : 允许加载任何内容
- `'none'` : 不允许加载任何内容
- `'self'`' : 允许加载相同源的内容
- `www.a.com` : 允许加载指定域名的资源
- `*.a.com` : 允许加载 a.com 任何子域名的资源
- `https://a.com` : 允许加载 a.com 的 https 资源
- `https` : 允许加载 https 资源
- `data` : 允许加载 data: 协议，例如：base64编码的图片
- `'unsafe-inline'` : 允许加载 inline 资源，例如style属性、onclick、inline js、inline css等
- `'unsafe-eval'` : 允许加载动态 js 代码，例如 eval()

## 例子

- 所有内容均来自网站的自己的域：
  - `Content-Security-Policy: default-src 'self'`

- 所有内容都来自网站自己的域，还有其他子域（假如网站的地址是：a.com）：
  - `Content-Security-Policy: default-src 'self' *.a.com`

- 网站接受任意域的图像，指定域（a.com）的音频、视频和多个指定域（a.com、b.com）的脚本
  - `Content-Security-Policy: default-src 'self';img-src *;media-src a.com;script-src a.com b.com`

## 默认特性

CSP除了使用白名单机制外，默认配置下阻止内联代码执行

```html
<!-- script代码 -->
<script>getyourcookie()</script>
<!-- 内联事件 -->
<a href="" onclick="handleClick();"></a> 
<a href="javascript:handleClick();"></a>
<!-- 内联样式 -->
<div style="display:none"></div>
```

`eval()` , `newFunction()` , `setTimeout([string], …)` 和 `setInterval([string], …)` 都被禁止运行。

# 分析报告

## 用 JSON 报告到接口

`Content-Security-Policy: default-src self; report-uri http://reportcollector.example.com/collector.cgi`

只汇报报告，不阻止任何内容，可以改用 `Content-Security-Policy-Report-Only` 头。

### JSON 对象包含以下数据

`blocked-uri` : 被阻止的违规资源
`document-uri` : 拦截违规行为发生的页面
`original-policy` : Content-Security-Policy头策略的所有内容
`referrer` : 页面的referrer
`status-code` : HTTP响应状态
`violated-directive` : 违规的指令

```json
{
  "csp-report": {
    "document-uri": "http://example.com/signup.html",
    "referrer": "",
    "blocked-uri": "http://example.com/css/style.css",
    "violated-directive": "style-src cdn.example.com",
    "original-policy": "default-src 'none'; style-src cdn.example.com; report-uri /_/csp-reports",
  }
}
```

```php
<?php 
$file = fopen('csp-report.txt', 'a');
$json = file_get_contents('php://input');
try {
    $csp = json_decode($json, true);
} catch (Exception $e) {
    exit();
}
fwrite($file, 'Date: ' . date('Y-m-d H:i:s') . " IP: " . $_SERVER['REMOTE_ADDR'] . " UA: " . $_SERVER['HTTP_USER_AGENT'] . " URI: " . $_SERVER['REQUEST_URI']);
foreach ($csp['csp-report'] as $key => $val) {
    fwrite($file, $key . ': ' . $val . "
");
}
fwrite($file, '=====' . "
");
fclose($file);
?>
```

<!-- https://blog.csdn.net/qq_32247819/article/details/124446652 -->
