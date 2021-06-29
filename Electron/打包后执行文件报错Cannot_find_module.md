```
Uncaught Exception:
Error: Cannot find module '\resources\app\index.js'
    at Module._resolveFilename (internal/modules/cjs/loader.js:797:17)
    at Function.o._resolveFilename (electron/js2c/browser_init.js:281:681)
    at Object.<anonymous> (electron/js2c/browser_init.js:205:3333)
    at Object../lib/browser/init.ts (electron/js2c/browser_init.js:205:3577)
    at __webpack_require__ (electron/js2c/browser_init.js:1:128)
    at electron/js2c/browser_init.js:1:1200
    at electron/js2c/browser_init.js:1:1267
    at NativeModule.compile (internal/bootstrap/loaders.js:287:5)
    at NativeModule.compileForPublicLoader (internal/bootstrap/loaders.js:222:8)
    at loadNativeModule (internal/modules/cjs/helpers.js:23:9)
```

# 核心错误信息是说没有找到 index.js 这个模块。
我们的应用中其实并没有 `index.js` 模块，于是仔细观察 `package.json` 文件，发现没有 `main` 这个节点，而这个节点是配置应用入口JS文件的。

# 在package.json 中增加 main 节点，如下：
```
{
  "main": "main.js",
  "scripts": {
      ...
```

# TS
```
{
  "main": "dist/main.js",
  "scripts": {
      ...
```