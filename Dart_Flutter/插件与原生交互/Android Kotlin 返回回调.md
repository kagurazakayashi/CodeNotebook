# 在 Flutter 的 Android 原生端（Kotlin/Java），`MethodChannel.Result` 是一个**回调接口**，用于将执行结果返回给 Dart 层

它主要有 **3 个** 核心方法。你可以把它想象成一个“一次性”的传声筒：一旦你调用了其中任何一个方法，这次通信就结束了。

---

## 1. `result.success(Any? result)`

**用途**：操作成功，向 Flutter 返回数据。

* **参数**：可以传递 `null`，或者任何 Flutter 支持的基础类型（`String`, `Int`, `Boolean`, `Map`, `List`, `ByteArray` 等）。
* **Flutter 表现**：Dart 端的 `await invokeMethod` 会正常返回这个值。

```kotlin
// 返回一个简单的字符串
result.success("Hello from Android!")

// 返回一个复杂的 Map
val data = mapOf("status" to "connected", "rssi" to -60)
result.success(data)

// 仅仅告诉前端“我做完了”，不传值
result.success(null)
```

---

## 2. `result.error(String errorCode, String? errorMessage, Any? errorDetails)`

**用途**：操作失败或发生异常。

* **参数**：
    1. `errorCode`：错误码（自定义字符串，如 `"404"`, `"BLE_OFF"`）。
    2. `errorMessage`：错误描述（给人读的提示文字）。
    3. `errorDetails`：详细信息（通常传 `null`，也可以传异常堆栈）。
* **Flutter 表现**：Dart 端会抛出一个 `PlatformException`，你可以用 `try-catch` 捕获。

```kotlin
if (!isBluetoothEnabled) {
    result.error(
        "BLE_DISABLED",
        "蓝牙未开启，请先开启蓝牙",
        null
    )
}
```

---

## 3. `result.notImplemented()`

**用途**：告诉 Flutter，原生端没有实现这个方法名。

* **场景**：通常用在 `when` 表达式的 `else` 分支。
* **Flutter 表现**：Dart 端会抛出 `MissingPluginException`。

```kotlin
override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
        "startScan" -> { /* 逻辑 */ }
        else -> {
            // 如果 Flutter 调用了一个我没写的方法名
            result.notImplemented()
        }
    }
}
```

---

## ⚠️ 使用时的“潜规则”（非常重要）

### 1. 只能调用一次 (Exactly Once)

对于同一个 `result` 对象，**必须且只能**调用上述三个方法中的其中一个，且只能调用一次。

* 如果你调用了两次 `result.success`，程序会抛出 `IllegalStateException`。
* 如果你忘记调用任何方法，Dart 端的 `await` 会**永久挂起（卡死）**。

### 2. 必须在主线程调用

`MethodChannel` 的所有操作（包括返回结果）必须在 **Android 主线程 (UI Thread)** 执行。如果你在子线程（如协程或线程池）里处理逻辑，返回结果时必须切回主线程：

```kotlin
// 在协程中处理耗时操作
scope.launch(Dispatchers.IO) {
    val data = doHeavyWork()

    // 切回主线程返回结果
    withContext(Dispatchers.Main) {
        result.success(data)
    }
}
```

### 3. 错误处理的最佳实践

即使你的原生代码崩溃了，也建议捕获异常并调用 `result.error`，而不是让插件直接闪退：

```kotlin
try {
    val value = riskyBusiness()
    result.success(value)
} catch (e: Exception) {
    result.error("NATIVE_ERROR", e.localizedMessage, null)
}
```

---

**既然你已经了解了如何返回结果，你需要我帮你写一个在原生端处理耗时操作并安全返回 `result.success` 的协程示例吗？**
