// =============================================================================
// Flutter 新擬物化（Neumorphism）設計實作備忘錄
// =============================================================================
// 套件：flutter_neumorphic_plus (^3.3.0)
// 參考專案：myTongdyPro（空氣品質感測器數據中心前端）
//
// 核心概念：
//   - 新擬物化通過「亮面陰影 + 暗面陰影」在淺灰底色上產生凸出/凹陷的立體感
//   - 光源方向（lightSource）決定亮暗陰影的分佈方向
//   - 正 depth → 凸出（convex），負 depth → 凹陷（emboss/inset）
//   - intensity 控制陰影對比度（0=無陰影，1=最強）
//
// 套件：pubspec.yaml
//   flutter_neumorphic_plus: ^3.3.0
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

// =============================================================================
// 一、全域主題設定（main.dart）
// =============================================================================
// 使用 NeumorphicApp 取代 MaterialApp，並設定 NeumorphicThemeData。
// 主題參數會由所有子組件繼承。

class MyAppExample extends StatelessWidget {
  const MyAppExample({super.key});

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(                     // ← 取代 MaterialApp
      title: 'MyTongdy',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,             // 目前僅使用淺色模式（新擬物化需要淺灰底色）
      theme: const NeumorphicThemeData(
        // 底色：經典新擬物化淺灰 #E0E5EC
        // 這是整個 UI 的基準色，所有亮/暗陰影都以此色為基準計算
        baseColor: Color(0xFFE0E5EC),

        // 光源方向：左上 → 左上角有亮面陰影，右下角有暗面陰影
        // 可用值：topLeft, topRight, bottomLeft, bottomRight
        lightSource: LightSource.topLeft,

        // 預設深度（0~20+）：數值越大，組件站得越"高"
        depth: 4,

        // 預設強度（0.0~1.0）：0=完全平面，1=陰影最強
        intensity: 0.6,
      ),
      home: const SomePage(),
    );
  }
}

// =============================================================================
// 二、從主題獲取顏色（用於自訂組件的文字色 / 背景色）
// =============================================================================

class ColorAccessExample extends StatelessWidget {
  const ColorAccessExample({super.key});

  @override
  Widget build(BuildContext context) {
    // 獲取主題設定的預設文字色（會根據 baseColor 自動計算出適當對比度）
    final textColor = NeumorphicTheme.defaultTextColor(context);

    // 獲取主題的底色
    final bgColor = NeumorphicTheme.baseColor(context);

    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Text('Hello', style: TextStyle(color: textColor)),
      ),
    );
  }
}

// =============================================================================
// 三、新擬物化組件使用手冊
// =============================================================================

// ---------------------------------------------------------------------------
// 3.1 凸出容器（Neumorphic）— 卡片/面板
// ---------------------------------------------------------------------------
// 用途：將內容區塊從背景中"抬起"，適用於卡片、表單區塊、資料面板等。
// 特徵：depth > 0，通常搭配 roundRect 圓角。

class ConvexCardExample extends StatelessWidget {
  const ConvexCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Neumorphic(
        style: NeumorphicStyle(
          depth: 8,                             // 深度 8（高度突出，適合寬屏懸浮卡片）
          intensity: 0.8,                      // 強度 0.8（對比度較高）
          shape: NeumorphicShape.flat,         // flat = 平面凸起（最常用）
          // 其他 shape 選項：
          //   convex  → 內表面微凸（邊緣有額外曲率）
          //   concave → 內表面微凹
          boxShape: NeumorphicBoxShape.roundRect(
            const BorderRadius.all(Radius.circular(24)), // 大圓角 → 柔和感
          ),
          color: const Color(0xFFF5F9F6),     // 可覆蓋預設底色（讓卡片稍亮於背景）
        ),
        child: const Padding(
          padding: EdgeInsets.all(40),
          child: Text('卡片內容'),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3.2 凸出容器（中強度）— 適合窄屏或小卡片
// ---------------------------------------------------------------------------

class MediumConvexExample extends StatelessWidget {
  const MediumConvexExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: 4,                               // 深度 4（中等突出）
        intensity: 0.5,                        // 強度 0.5（中等對比）
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(
          const BorderRadius.all(Radius.circular(20)), // 中圓角
        ),
        color: const Color(0xFFF5F9F6),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 36),
        child: Text('窄屏內容'),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3.3 凹陷容器 — 輸入框（emboss / inset）
// ---------------------------------------------------------------------------
// 用途：讓 TextField 看起來像"壓入"背景中的槽位。
// 特徵：depth 為負值（項目中使用 -2），同時 boxShape 內的顏色可以稍深於卡片顏色。

class EmbossInputExample extends StatelessWidget {
  const EmbossInputExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: -2,                              // 負值 → 凹陷效果
        intensity: 0.4,                        // 強度 0.4（凹陷陰影較弱）
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(
          const BorderRadius.all(Radius.circular(12)), // 輸入框用小圓角
        ),
        // 凹陷底色略深於外層卡片，強化"槽位"視覺
        color: const Color(0xFFF0F4F1),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: '請輸入...',
          hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
          prefixIcon: Icon(Icons.person_outline, color: Color(0xFF81C784)),
          border: InputBorder.none,            // 去掉 Material 邊框
          // 用 InputBorder.none + Neumorphic 凹陷完成所有視覺
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3.4 FAB 替代 — NeumorphicFloatingActionButton
// ---------------------------------------------------------------------------

class FABExample extends StatelessWidget {
  const FABExample({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = NeumorphicTheme.defaultTextColor(context);
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      floatingActionButton: NeumorphicFloatingActionButton(
        onPressed: () {},
        tooltip: '增加',
        style: const NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.circle(), // 圓形按鈕
          depth: 6,                             // 深度 6（比一般卡片突出）
          intensity: 0.9,                      // 強度 0.9（非常明顯）
        ),
        child: Icon(Icons.add, color: textColor),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3.5 AppBar 替代 — NeumorphicAppBar
// ---------------------------------------------------------------------------
// NeumorphicAppBar 會自動套用 neumorphic 陰影，比標準 AppBar 更貼合主題。

class AppBarExample extends StatelessWidget {
  const AppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = NeumorphicTheme.defaultTextColor(context);
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      appBar: NeumorphicAppBar(
        title: Text('首頁', style: TextStyle(color: textColor)),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: textColor),
            onPressed: () {},
          ),
        ],
      ),
      body: const SizedBox.shrink(),
    );
  }
}

// ---------------------------------------------------------------------------
// 3.6 凸起文字 — NeumorphicText
// ---------------------------------------------------------------------------
// 讓文字本身產生微凸的立體效果（裝飾用，非必要功能文字）

class NeumorphicTextExample extends StatelessWidget {
  const NeumorphicTextExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: Center(
        child: NeumorphicText(
          '你已經按下按鈕',
          style: const NeumorphicStyle(
            depth: 1,                           // 輕微凸起（文字深度不宜過大）
            intensity: 0.3,                    // 弱強度
          ),
          textStyle: const NeumorphicTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3.7 響應式佈局中的深度調節
// ---------------------------------------------------------------------------
// 寬螢幕時卡片更突出（depth=8），窄螢幕時更貼合（depth=4）。
// 透過 LayoutBuilder 檢測可用寬度。

class ResponsiveDepthExample extends StatelessWidget {
  const ResponsiveDepthExample({super.key});

  static const double _kBreakpoint = 600.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= _kBreakpoint;
          return Center(
            child: Neumorphic(
              style: NeumorphicStyle(
                depth: isWide ? 8 : 4,          // 寬屏用深度 8，窄屏用 4
                intensity: isWide ? 0.8 : 0.5, // 寬屏更高對比度
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.all(Radius.circular(isWide ? 24 : 20)),
                ),
                color: const Color(0xFFF5F9F6),
              ),
              child: const Padding(
                padding: EdgeInsets.all(32),
                child: Text('響應式內容'),
              ),
            ),
          );
        },
      ),
    );
  }
}

// =============================================================================
// 四、參數速查表
// =============================================================================
//
// depth 參數指南：
//   -2  凹陷輸入框      （emboss/inset，像按入表面的槽位）
//    1  輕微凸起文字    （裝飾性立體字）
//    4  中等突出        （窄屏卡片、一般資訊面板；全域預設值）
//    6  較強突出        （FAB 按鈕，需要抓住注意力）
//    8  高度突出        （寬屏懸浮卡片，強調浮空感）
//
// intensity 參數指南：
//   0.3  弱強度（文字凸起）
//   0.4  弱強度（凹陷槽位）
//   0.5  中等（窄屏卡片）
//   0.6  中等（全域預設）
//   0.8  較強（寬屏卡片、計數器）
//   0.9  最強（FAB 按鈕）
//
// shape 參數：
//   NeumorphicShape.flat    平面凸起/凹陷（最常用，本專案全部使用此值）
//   NeumorphicShape.convex  內表面微微隆起（邊緣有曲面）
//   NeumorphicShape.concave 內表面微微凹入（反曲面）
//
// boxShape 參數：
//   NeumorphicBoxShape.roundRect(…)  圓角矩形（圓角大小可調）
//   NeumorphicBoxShape.circle()       圓形
//
// 圓角大小分級：
//   12px   輸入框（緊湊、功能明確）
//   16px   小型資訊卡片
//   20px   窄屏卡片
//   24px   寬屏懸浮卡片
//   circle  FAB

// =============================================================================
// 五、配色建議
// =============================================================================
//
// 底色（NeumorphicTheme.baseColor）：
//   經典灰   Color(0xFFE0E5EC)   最通用的新擬物化底色
//
// 卡片底色（Neumorphic.color）：
//   淺白綠   Color(0xFFF5F9F6)   略亮於背景，提升層次感
//   淺米白   Color(0xFFF0F4F1)   凹陷輸入框底色，略深於卡片
//
// 主題色（非 neumorphic 組件用）：
//   主綠色   Color(0xFF43A047)   Material Green 600
//   淺綠色   Color(0xFF81C784)   Material Green 300
//   薄荷綠   Color(0xFFC8E6C9)   Material Green 100（背景漸變起點）
//   天空青   Color(0xFFB2DFDB)   Material Teal 100（背景漸變終點）

// =============================================================================
// 六、實務要點
// =============================================================================
//
// 1. NeumorphicApp 必須在 Widget 樹最外層並位於 MaterialApp 的位置。
//
// 2. 所有 Neumorphic 組件必須放置於 NeumorphicApp 的子樹中，否則無法
//    繼承 NeumorphicThemeData。
//
// 3. 凹陷輸入框的 TextField 必須設 border: InputBorder.none，
//    否則 Material 樣式的邊框會破壞 neumorphic 效果。
//
// 4. 登入按鈕等主要操作按鈕建議不使用 neumorphic 樣式 ——
//    改用傳統漸變色 + BoxShadow，讓它在 neumorphic 背景中成為唯一的
//    "行動召喚"（CTA）元素，視覺層次更清晰。
//
// 5. 新擬物化不適合深色主題 —— 暗色背景下亮/暗陰影對比度不足，
//    本專案將 themeMode 鎖定為 ThemeMode.light。
//
// 6. 使用 NeumorphicTheme.defaultTextColor(context) 取代硬編碼文字色，
//    讓系統根據 baseColor 自動計算合適的對比度。
//
// 7. 在不同頁面/容器使用不同 depth 和 intensity 創造清晰的視覺層次：
//    背景 < 凹陷槽位 < 中等卡片 < 高懸浮卡片 < FAB
//
// 8. 響應式設計中，透過 LayoutBuilder + constraints.maxWidth 切換
//    depth/intensity/圓角，讓寬窄屏各自獲得適當的視覺權重。
//
// 9. 非 Neumorphic 的 Material 組件（如 BottomSheet、SnackBar）
//    可共存，但它們的傳統陰影會與 neumorphic 陰影並存 ——
//    建議將這類組件的背景色設定為與 neumorphic 底色相近的淺色。
//
// 10. 此備忘錄基於 flutter_neumorphic_plus ^3.3.0，API 可能因版本不同而有差異。

// =============================================================================
// 七、完整登入頁骨架（示範上述所有技術的組合）
// =============================================================================

class CompleteLoginExample extends StatelessWidget {
  const CompleteLoginExample({super.key});

  static const double _kBreakpoint = 600.0;
  static const double _kCardMaxWidth = 440.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= _kBreakpoint;

                // 寬屏：限制最大寬度 + 高深度卡片
                // 窄屏：全寬 + 中深度卡片
                final child = Neumorphic(
                  style: NeumorphicStyle(
                    depth: isWide ? 8 : 4,
                    intensity: isWide ? 0.8 : 0.5,
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.all(Radius.circular(isWide ? 24 : 20)),
                    ),
                    color: const Color(0xFFF5F9F6),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(isWide ? 40 : 28),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // --- Logo 區塊 ---
                        // ... SvgPicture、標題文字等 ...
                        // --- 凹陷輸入框（server） ---
                        EmbossInputExample(),
                        SizedBox(height: 16),
                        // --- 凹陷輸入框（username） ---
                        EmbossInputExample(),
                        SizedBox(height: 16),
                        // --- 凹陷輸入框（password） ---
                        EmbossInputExample(),
                        SizedBox(height: 28),
                        // --- 登入按鈕（傳統漸變按鈕，非 neumorphic） ---
                        // ...
                      ],
                    ),
                  ),
                );

                if (isWide) {
                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: _kCardMaxWidth),
                      child: child,
                    ),
                  );
                }
                return child;
              },
            ),
          ),
        ),
      ),
    );
  }
}
