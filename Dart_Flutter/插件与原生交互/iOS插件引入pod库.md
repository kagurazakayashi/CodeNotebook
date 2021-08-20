1. 编辑 `ios/ya_websocket.podspec` ，加入所需库，例如
```
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
+ s.dependency 'Starscream', '~> 4.0.0'
  s.platform = :ios, '8.0'
```

2. 安装库
```
cd example/ios
pod install
```

3. 重新打开 `example/ios/Runner.xcworkspace`