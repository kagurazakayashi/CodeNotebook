# macOS 应用程序类别（LSApplicationCategoryType）

## 概述

macOS 通过 `Info.plist` 中的 **`LSApplicationCategoryType`** 键定义应用类别。该值用于 **Mac App Store** 分类、**Launchpad** 分组以及 **系统信息** 中的应用归类。

该键的值是一个 UTI（Uniform Type Identifier）格式的字符串，如 `public.app-category.developer-tools`。

---

## 使用语法

在 Xcode 项目中，在 `Info.plist` 中添加：

```xml
<key>LSApplicationCategoryType</key>
<string>public.app-category.developer-tools</string>
```

在非 Xcode 构建的应用中，在 `Contents/Info.plist`（位于 `.app/Contents/` 下）中手动添加上述键值。

---

## 完整类别列表

### 商业（Business）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.business` | 商业 |

### 开发工具（Developer Tools）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.developer-tools` | 开发工具 |

### 教育（Education）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.education` | 教育 |
| `public.app-category.educational-games` | 教育游戏 |
| `public.app-category.education.languages` | 语言学习 |

### 娱乐（Entertainment）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.entertainment` | 娱乐 |

### 财务（Finance）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.finance` | 财务 |

### 餐饮（Food & Drink）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.food-and-drink` | 餐饮 |

### 游戏（Games）

游戏是子类别最多的分类，所有游戏类别必须以 `public.app-category.games` 为前缀。

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.games` | 游戏（通用/杂项） |
| `public.app-category.action-games` | 动作游戏 |
| `public.app-category.adventure-games` | 冒险游戏 |
| `public.app-category.board-games` | 棋盘游戏 |
| `public.app-category.card-games` | 纸牌游戏 |
| `public.app-category.casino-games` | 赌场游戏 |
| `public.app-category.dice-games` | 骰子游戏 |
| `public.app-category.educational-games` | 教育游戏 |
| `public.app-category.family-games` | 家庭游戏 |
| `public.app-category.kids-games` | 儿童游戏 |
| `public.app-category.music-games` | 音乐游戏 |
| `public.app-category.puzzle-games` | 益智/解谜游戏 |
| `public.app-category.racing-games` | 竞速游戏 |
| `public.app-category.role-playing-games` | 角色扮演游戏 |
| `public.app-category.simulation-games` | 模拟游戏 |
| `public.app-category.sports-games` | 体育游戏 |
| `public.app-category.strategy-games` | 策略游戏 |
| `public.app-category.trivia-games` | 问答/益智问答游戏 |
| `public.app-category.word-games` | 文字游戏 |

### 图形与设计（Graphics & Design）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.graphics-design` | 图形与设计 |

### 健康与健身（Health & Fitness）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.healthcare-fitness` | 健康与健身 |
| `public.app-category.healthcare-fitness.meditation` | 冥想 |

### 生活（Lifestyle）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.lifestyle` | 生活 |

### 医疗（Medical）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.medical` | 医疗 |
| `public.app-category.medical.health-records` | 健康记录 |
| `public.app-category.medical.education` | 医疗教育 |

### 音乐（Music）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.music` | 音乐 |
| `public.app-category.music.midi` | MIDI |
| `public.app-category.music.daws` | 数字音频工作站（DAW） |
| `public.app-category.music.music-video` | 音乐视频 |
| `public.app-category.music.instruments` | 乐器 |
| `public.app-category.music.karaoke` | 卡拉 OK |

### 导航（Navigation）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.navigation` | 导航 |

### 新闻（News）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.news` | 新闻 |
| `public.app-category.news.magazines-newspapers` | 杂志与报纸 |

### 摄影（Photography）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.photography` | 摄影 |

### 效率（Productivity）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.productivity` | 效率 |

### 参考（Reference）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.reference` | 参考 |

### 购物（Shopping）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.shopping` | 购物 |

### 社交网络（Social Networking）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.social-networking` | 社交网络 |

### 体育（Sports）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.sports` | 体育 |

### 旅游（Travel）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.travel` | 旅游 |

### 工具（Utilities）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.utilities` | 工具 |

### 视频（Video）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.video` | 视频 |

### 天气（Weather）

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.weather` | 天气 |

### 图书（Books） — macOS 13+ / iOS

| 类别值 | 中文说明 |
|--------|----------|
| `public.app-category.books` | 图书/阅读 |

---

## 应用方法

### 1. 在 Xcode 项目中设置

1. 打开项目，选择 Target
2. 进入 **General** → **App Category**
3. 从下拉菜单中选择主类别和子类别

Xcode 会自动在 `Info.plist` 中写入对应的 `LSApplicationCategoryType` 值。

### 2. 手动编辑 Info.plist

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <!-- 省略其他键 -->

    <!-- 主类别：开发工具 -->
    <key>LSApplicationCategoryType</key>
    <string>public.app-category.developer-tools</string>

</dict>
</plist>
```

### 3. 用命令行读写 Info.plist

```bash
# 读取当前类别
/usr/libexec/PlistBuddy -c "Print LSApplicationCategoryType" 程序.app/Contents/Info.plist

# 写入新类别
/usr/libexec/PlistBuddy -c "Set LSApplicationCategoryType public.app-category.developer-tools" 程序.app/Contents/Info.plist

# 删除类别键
/usr/libexec/PlistBuddy -c "Delete LSApplicationCategoryType" 程序.app/Contents/Info.plist

# 如果是键不存在则添加（Add 失败时会报错，可改用以下方式）
/usr/libexec/PlistBuddy -c "Add LSApplicationCategoryType string public.app-category.developer-tools" 程序.app/Contents/Info.plist
```

### 4. 用 defaults 命令操作

```bash
# 读取
defaults read /路径/程序.app/Contents/Info LSApplicationCategoryType

# 写入
defaults write /路径/程序.app/Contents/Info LSApplicationCategoryType -string "public.app-category.developer-tools"
```

### 5. 用 plutil 转换为可编辑格式

```bash
# 将二进制 plist 转为 XML 文本
plutil -convert xml1 程序.app/Contents/Info.plist -o Info_text.plist

# 编辑 Info_text.plist 后再转回二进制
plutil -convert binary1 Info_text.plist -o 程序.app/Contents/Info.plist
```

---

## 完整示例：一个开发工具的 Info.plist（节选）

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>zh_CN</string>
    <key>CFBundleDisplayName</key>
    <string>我的开发工具</string>
    <key>CFBundleExecutable</key>
    <string>MyDevTool</string>
    <key>CFBundleIdentifier</key>
    <string>com.example.MyDevTool</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>MyDevTool</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0.0</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>LSApplicationCategoryType</key>
    <string>public.app-category.developer-tools</string>
    <key>LSMinimumSystemVersion</key>
    <string>11.0</string>
    <key>NSHighResolutionCapable</key>
    <true/>
</dict>
</plist>
```

---

## Info.plist 常用键速查（与类别相关）

| 键 | 说明 |
|----|------|
| `CFBundleIdentifier` | 唯一标识符（反向域名格式） |
| `CFBundleDisplayName` | 菜单栏和 Dock 中显示的名称 |
| `CFBundleName` | 短名称（≤16 字符） |
| `CFBundleExecutable` | 可执行文件名 |
| `CFBundlePackageType` | `APPL` = 应用程序，`BNDL` = 捆绑包 |
| `CFBundleVersion` | 内部构建版本号 |
| `CFBundleShortVersionString` | 对外发布的版本号 |
| `LSApplicationCategoryType` | 应用分类 |
| `LSMinimumSystemVersion` | 最低 macOS 系统版本要求 |
| `NSHighResolutionCapable` | 是否支持 Retina 高分屏 |
| `CFBundleDocumentTypes` | 关联的文件类型 |
| `NSSupportsAutomaticTermination` | 是否允许系统自动终止进程 |
| `LSBackgroundOnly` | 是否为纯后台应用 |
| `LSUIElement` | 是否仅作为菜单栏应用（无 Dock 图标） |

---

## 注意事项

1. **不使用 Mac App Store 分发的应用**，`LSApplicationCategoryType` 对 Launchpad 分类仍然有效。
2. 游戏子类别格式有两种历史风格，当前统一推荐 `public.app-category.*-games`（如 `action-games`）。
3. 从 macOS 14 起，Apple 对非 App Store 分发的应用类别校验不严格，但仍建议填写正确值。
4. `LSApplicationCategoryType` 键**区分大小写**，必须完全匹配 Apple 定义的值。
5. 子类别对应的主类别由系统自动推导，填写子类别即可。

---

> 参考文档：[Apple Developer - LSApplicationCategoryType](https://developer.apple.com/documentation/bundleresources/information_property_list/lsapplicationcategorytype)
