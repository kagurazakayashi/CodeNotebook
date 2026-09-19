# -*- coding: utf-8 -*-
# =====================================================================================
# DashScope 百煉視訊生成工具 (bailianv.py)
# 功能：透過阿里雲 DashScope API 生成 AI 視訊（圖生視訊/文生視訊/視訊編輯）
#
# 必要套件安裝（請於終端機執行）：
#   pip install requests
# =====================================================================================

import requests         # HTTP 請求庫，用於與 DashScope API 通訊
import json             # JSON 編碼/解碼，用於構建請求體與解析回應
import base64           # Base64 編碼，將本地媒體檔案轉為 API 所需的 data URI
import os               # 作業系統介面，用於檢查本地檔案是否存在
import subprocess       # 子行程管理，用於呼叫外部播放器進行循環播放
import shutil           # 進階檔案/命令工具，用於檢測 ffplay 等播放器是否可用
import time             # 時間處理，用於輪詢計時與經過時間顯示
from urllib.parse import urlparse  # URL 解析，用於從視訊下載網址中提取檔案名稱


# =====================================================================================
# 第一節：使用者設定區 —— 請根據實際需求修改以下各項設定
# =====================================================================================

# -------------------------------------------------------------------
# 1-1. API 認證
# -------------------------------------------------------------------
# 您的 DashScope API 金鑰（必填）
# 請至阿里雲百煉平台取得：https://bailian.console.aliyun.com/
# 格式通常為 "sk-" 開頭，後接 32 位元十六進位字元
API_KEY = "sk-"

# -------------------------------------------------------------------
# 1-2. 模型選擇
# -------------------------------------------------------------------
# 設定要使用的視訊生成模型，可選值如下：
#
#   "happyhorse-1.0-i2v"        — 圖生視訊（Image-to-Video）
#                                 根據一張首幀圖像生成完整視訊
#                                 需要提供 input.media，type 須為 "first_frame"
#
#   "happyhorse-1.0-t2v"        — 文生視訊（Text-to-Video）
#                                 根據純文字描述生成視訊，不須任何媒體素材
#                                 可選設定 parameters.ratio 來控制畫面比例
#
#   "happyhorse-1.0-r2v"        — 參考圖生視訊（Reference-to-Video）
#                                 根據至少一張參考圖生成視訊
#                                 需要在 prompt 中以 [Image 1]、[Image 2] 引用
#
#   "happyhorse-1.0-video-edit" — 視訊編輯（Video Editing）
#                                 對一段既有視訊進行風格化編輯
#                                 必須提供 type="video" 的素材，可額外提供參考圖
MODEL_TYPE = "happyhorse-1.0-i2v"

# -------------------------------------------------------------------
# 1-3. 提示詞（Prompt）
# -------------------------------------------------------------------
# 描述想要生成的視訊內容，支援中文與英文（必填）
# 建議清晰描述場景、動作、鏡頭運動，以獲得最佳生成效果
#
# 若使用 happyhorse-1.0-r2v 模型，須在 prompt 中明確指代每張參考圖：
#   使用 [Image 1]、[Image 2]... 標記來引用對應的參考圖
#   參考圖的順序與 media 陣列順序必須嚴格一致，標記索引從 1 開始
#   範例："[Image 1]中的古典建築風格，結合[Image 2]的燈光設計，生成夜晚街景"
PROMPT = ""

# -------------------------------------------------------------------
# 1-4. 媒體素材設定（根據所選模型類型調整）
# -------------------------------------------------------------------
# 不同模型對媒體素材的需求如下：
#
# happyhorse-1.0-i2v：
#   需要 1 張首幀圖像作為生成起點
#   - type 固定為 "first_frame"
#   - 支援格式：jpg / jpeg / png / webp
#
# happyhorse-1.0-t2v：
#   不需要任何媒體素材，請將 MEDIA_FILES 設為空列表 []
#
# happyhorse-1.0-r2v：
#   需要至少 1 張參考圖
#   - type 固定為 "reference_image"
#   - 可提供多張參考圖，數量無嚴格上限
#   - 支援格式：jpg / jpeg / png / webp
#   - 必須在 prompt 中以 [Image N] 引用對應的參考圖
#
# happyhorse-1.0-video-edit：
#   必須提供 1 段待編輯的視訊，可額外提供參考圖
#   - type="video"：必選，提供待編輯的原始視訊
#   - type="reference_image"：可選，提供風格參考圖
#   - 視訊支援格式：mp4；圖片支援格式：jpg / jpeg / png / webp
if MODEL_TYPE == "happyhorse-1.0-i2v":
    MEDIA_FILES = [
        {"type": "first_frame", "path": "IMG20260517011318.jpg"}
        # type : 固定為 "first_frame"
        # path : 本地首幀圖片檔案路徑（支援 jpg / png / webp）
    ]
elif MODEL_TYPE == "happyhorse-1.0-r2v":
    MEDIA_FILES = [
        {"type": "reference_image", "path": "ref1.jpg"},
        {"type": "reference_image", "path": "ref2.png"}
        # type : 固定為 "reference_image"，可配置多張
        # path : 本地參考圖檔案路徑（支援 jpg / png / webp）
        # 注意：須在 prompt 中使用 [Image 1]、[Image 2] 來引用
    ]
elif MODEL_TYPE == "happyhorse-1.0-video-edit":
    MEDIA_FILES = [
        {"type": "video", "path": "input_video.mp4"},
        {"type": "reference_image", "path": "style_ref.jpg"}
        # type : "video"（必選，提供待編輯視訊）| "reference_image"（可選，風格參考圖）
        # path : 視訊支援 mp4；圖片支援 jpg / png / webp
    ]
elif MODEL_TYPE == "happyhorse-1.0-t2v":
    MEDIA_FILES = []  # 文生視訊無需媒體素材，保持空列表即可

# -------------------------------------------------------------------
# 1-5. 生成參數
# -------------------------------------------------------------------
PARAMS = {
    # 解析度檔位（必填），可選值：
    #   "720P"  — 1280x720，適合快速預覽，費用較低
    #   "1080P" — 1920x1080，適合正式使用，費用較高
    "resolution": "1080P",

    # 視訊時長（必填），單位為秒，必須為整數
    # 取值範圍：[3, 15]，超過範圍會在校驗階段報錯
    "duration": 15,

    # 是否添加浮水印（可選，預設為 True）
    #   True  — 生成的視訊右下角會帶有 DashScope 浮水印
    #   False — 不添加浮水印（部分模型可能需要企業版權限）
    "watermark": False,

    # 隨機種子（可選，限 happyhorse-1.0-i2v / t2v）
    # 設定後可使相同輸入產生相同的輸出，便於結果復現
    # 若要使用，取消下一行的註解並設定整數值：
    # "seed": 42,

    # 畫面寬高比（可選，僅 happyhorse-1.0-t2v 支援）
    # 常見比例："16:9"（預設橫屏）、"9:16"（直屏）、"1:1"（方形）
    # 若要使用，取消下一行的註解並設定比例字串：
    # "ratio": "16:9",
}

# -------------------------------------------------------------------
# 1-6. 輸出檔案設定
# -------------------------------------------------------------------
# 此為兜底檔案名，當伺服器未返回明確檔案名時使用
# 下載時會優先使用伺服器在 Content-Disposition 標頭中指定的檔案名
# 其次會從視訊 URL 路徑中自動提取檔案名
OUTPUT_FILE = "output.mp4"

# -------------------------------------------------------------------
# 1-7. 費用設定（單位：元人民幣 / 每秒視訊）
# -------------------------------------------------------------------
# 每個模型按解析度檔位設定單價，可根據官方公告隨時調整
# 計費公式：預估費用 = 單價 × 時長 × 折扣倍率
# 實際費用以阿里雲帳單為準，此處僅供參考估算
#
# 目前官方定價參考（2025 年）：
#   720P ：0.9  元/秒
#   1080P：1.6  元/秒
#
# 如需新增模型或調整單價，直接在下方字典中修改對應值即可
PRICING = {
    "happyhorse-1.0-i2v":        {"720P": 0.9, "1080P": 1.6},   # 圖生視訊
    "happyhorse-1.0-t2v":        {"720P": 0.9, "1080P": 1.6},   # 文生視訊
    "happyhorse-1.0-r2v":        {"720P": 0.9, "1080P": 1.6},   # 參考圖生視訊
    "happyhorse-1.0-video-edit": {"720P": 0.9, "1080P": 1.6},   # 視訊編輯
}
# 折扣倍率設定
#   0.8 表示 8 折（目前官方活動折扣）
#   1.0 表示原價（無折扣時請設為 1.0）
DISCOUNT = 0.8

# -------------------------------------------------------------------
# 1-8. 輪詢設定
# -------------------------------------------------------------------
# 提交任務後需要定期查詢（輪詢）任務狀態，直到視訊生成完畢
# 以下兩個參數控制輪詢行為：
#
# POLL_INTERVAL：每次查詢之間的等待秒數
#   建議設定為 10-15 秒，太短可能被 API 限流，太長則等待時間增加
POLL_INTERVAL = 15

# MAX_POLL_COUNT：最大輪詢次數，超過此次數則視為超時並退出
#   例如間隔 15 秒、最大 20 次 → 最長等待 300 秒（5 分鐘）
#   若視訊較長或伺服器繁忙，可適當增大此值
MAX_POLL_COUNT = 20

# EXISTING_TASK_ID：若已有 task_id，可直接繼續輪詢並下載，留空則建立新任務
#   當程式意外中斷或需要重新下載時，可直接填入之前獲得的 task_id
#   設定後會跳過任務建立步驟，直接進入輪詢流程
EXISTING_TASK_ID = ""


# =====================================================================================
# 第二節：設定顯示與校驗函式
# =====================================================================================

def calc_cost(model: str, resolution: str, duration: float) -> float:
    """計算預估費用。

    根據模型名稱、解析度檔位和視訊時長，查詢單價後乘以折扣計算。
    計費公式：單價（元/秒）× 時長（秒）× 折扣倍率

    參數:
        model      : 模型名稱，例如 "happyhorse-1.0-i2v"
        resolution : 解析度字串，例如 "720P" 或 "1080P"
        duration   : 視訊時長，單位為秒（支援浮點數）

    回傳:
        float — 預估費用（元），若找不到對應單價則回傳 0
    """
    # 從 PRICING 字典中查詢對應模型和解析度的單價
    unit_price = PRICING.get(model, {}).get(resolution, 0)
    # 返回 單價 × 時長 × 折扣 的結果
    return unit_price * duration * DISCOUNT


def format_elapsed(seconds: float) -> str:
    """將秒數格式化為人類易讀的「Xh Xm Xs」格式。

    例：
        30 秒  → "30s"
        90 秒  → "1m 30s"
        3661 秒 → "1h 1m 1s"

    參數:
        seconds : 經過秒數（支援浮點數，會自動取整）

    回傳:
        str — 格式化後的字串，如 "1m 23s"
    """
    s = int(seconds)               # 將浮點秒數轉為整數
    h, r = divmod(s, 3600)         # 計算小時數與剩餘秒數
    m, s = divmod(r, 60)           # 計算分鐘數與剩餘秒數
    parts = []                      # 收集格式化的區段
    if h:                           # 小時 > 0 才顯示
        parts.append(f"{h}h")
    if m or h:                      # 分鐘 > 0 或已有小時時顯示
        parts.append(f"{m}m")
    parts.append(f"{s}s")           # 秒數永遠顯示
    return " ".join(parts)          # 用空格連接各區段


def print_configuration() -> None:
    """在提交任務前列印所有使用者設定，供核對確認。

    此函式會在 main() 最開始被呼叫，列出：
      - API 金鑰（脫敏顯示，僅顯示前 8 位與後 4 位）
      - 所選模型名稱
      - 提示詞內容
      - 媒體素材清單（含檔案存在性檢查）
      - 生成參數（解析度、時長、浮水印、種子、比例等）
      - 費用預估（含單價、折扣、計算明細）
      - 輸出檔案名與輪詢設定
    """
    print("=" * 60)
    print("當前任務設定")
    print("=" * 60)

    # API 金鑰：僅顯示前 8 字元和後 4 字元，中間以 ... 替代，防止洩漏
    print(f"  API Key       : {API_KEY[:8]}...{API_KEY[-4:]}")

    # 模型名稱
    print(f"  模型名稱      : {MODEL_TYPE}")

    # 提示詞
    print(f"  提示詞        : {PROMPT}")

    # 媒體素材資訊
    # 文生視訊模型不須媒體素材
    if MODEL_TYPE == "happyhorse-1.0-t2v":
        print(f"  媒體素材      : （文生視訊，無需媒體素材）")
    else:
        # 逐一列出每個媒體檔案，並檢查本地檔案是否存在
        for i, item in enumerate(MEDIA_FILES, 1):
            # os.path.exists 檢查檔案是否存在於磁碟上
            file_exists = "存在" if os.path.exists(item["path"]) else "缺失!"
            print(f"  媒體[{i}]      : type={item['type']}, path={item['path']} ({file_exists})")

    # 生成參數：遍歷 PARAMS 字典，根據鍵名分類顯示
    has_extra_params = False        # 追蹤是否有非預設參數
    for k, v in PARAMS.items():
        if k == "resolution":
            print(f"  解析度        : {v}")
        elif k == "duration":
            print(f"  時長          : {v} 秒")
        elif k == "watermark":
            print(f"  浮水印        : {'已啟用' if v else '已禁用'}")
        elif k == "seed":
            print(f"  隨機種子      : {v}")
            has_extra_params = True
        elif k == "ratio":
            print(f"  畫面比例      : {v}")
            has_extra_params = True
        else:
            print(f"  {k}           : {v}")
            has_extra_params = True

    # 輸出與輪詢設定
    if EXISTING_TASK_ID:
        print(f"  既有 task_id   : {EXISTING_TASK_ID}（將跳過新任務建立）")
    print(f"  輸出檔案      : {OUTPUT_FILE}（若伺服器指定名稱則優先使用）")
    print(f"  輪詢間隔      : 每 {POLL_INTERVAL} 秒")
    print(f"  最大輪詢次數  : {MAX_POLL_COUNT} 次")

    # --- 費用預估 ---
    # 從 PARAMS 中讀取解析度和時長，計算預估花費
    resolution = PARAMS.get("resolution", "720P")
    duration = PARAMS.get("duration", 5)
    # 查詢單價
    unit_price = PRICING.get(MODEL_TYPE, {}).get(resolution, 0)
    # 計算預估費用
    estimated = calc_cost(MODEL_TYPE, resolution, duration)

    print(f"  計費模型      : {MODEL_TYPE}")
    print(f"  單價          : {unit_price} 元/秒 ({resolution})")
    print(f"  視訊時長      : {duration} 秒")
    if DISCOUNT < 1.0:
        # DISCOUNT=0.8 → 顯示 "8 折"
        print(f"  折扣          : {DISCOUNT * 10:.0f} 折")
    # 計算公式顯示：若有折扣則顯示含折扣的公式，否則僅顯示單價×時長
    formula = f"{unit_price} × {duration}"
    if DISCOUNT < 1.0:
        formula += f" × {DISCOUNT}"
    print(f"  預估費用      : {estimated:.2f} 元 (= {formula})")
    print("=" * 60)


def validate_config() -> None:
    """校驗所有使用者設定的合法性，發現問題時擲出例外。

    校驗項目包括：
      1. API_KEY 是否以 "sk-" 開頭（基本格式檢查）
      2. MODEL_TYPE 是否為已知的有效模型
      3. 非 t2v 模型是否提供了媒體素材且檔案存在
      4. duration 是否在 [3, 15] 範圍內
      5. resolution 是否為 "720P" 或 "1080P"
    """
    # 檢查 API 金鑰格式（DashScope 的 Key 以 sk- 開頭）
    if not API_KEY or API_KEY.startswith("sk-") is False:
        raise ValueError("API_KEY 無效，請填寫正確的 DashScope API 金鑰（應以 sk- 開頭）")

    # 已知的有效模型列表
    valid_models = [
        "happyhorse-1.0-i2v",
        "happyhorse-1.0-t2v",
        "happyhorse-1.0-r2v",
        "happyhorse-1.0-video-edit",
    ]
    if MODEL_TYPE not in valid_models:
        raise ValueError(f"未知的模型類型: {MODEL_TYPE}，可選值: {valid_models}")

    # 非文生視訊模型必須提供媒體素材
    if MODEL_TYPE != "happyhorse-1.0-t2v":
        if not MEDIA_FILES:
            raise ValueError(f"模型 {MODEL_TYPE} 必須提供媒體素材，但目前 MEDIA_FILES 為空")
        # 逐一檢查每個媒體檔案是否存在於本地檔案系統
        for item in MEDIA_FILES:
            if not os.path.exists(item["path"]):
                raise FileNotFoundError(f"媒體檔案不存在: {item['path']}")

    # 校驗視訊時長：必須在 3-15 秒範圍內
    duration = PARAMS.get("duration", 5)
    # 轉為整數後比對，確保使用者誤填浮點數時也能正確校驗
    if not (3 <= int(duration) <= 15):
        raise ValueError(f"duration 必須在 3-15 秒之間，目前設定: {duration}")

    # 校驗解析度：僅支援 720P 和 1080P 兩種
    resolution = PARAMS.get("resolution", "720P")
    if resolution not in ("720P", "1080P"):
        raise ValueError(f"resolution 必須為 720P 或 1080P，目前設定: {resolution}")


# =====================================================================================
# 第三節：核心功能函式
# =====================================================================================

def file_to_base64(file_path: str) -> str:
    """將本地檔案編碼為 Base64 字串。

    DashScope API 支援以 data URI 格式直接提交媒體檔案，
    因此需要將二進位檔案內容轉為 Base64 編碼。

    參數:
        file_path : 本地檔案的路徑

    回傳:
        str — Base64 編碼後的字串（不含 data URI 前綴）
    """
    # 以二進位模式（"rb"）讀取檔案，確保所有位元組完整讀入
    with open(file_path, "rb") as f:
        # base64.b64encode 回傳二進位資料，需 decode 為 UTF-8 字串
        return base64.b64encode(f.read()).decode("utf-8")


def build_media_list() -> list:
    """根據 MEDIA_FILES 設定構建 API 所需的 media 列表。

    此函式會：
      1. 根據每個檔案的副檔名判斷 MIME 類型
      2. 將檔案內容編碼為 Base64
      3. 組裝為 data URI 格式（data:{MIME};base64,{內容}）
      4. 保留原始 type 欄位供 API 辨識素材用途

    回傳:
        list[dict] — 符合 DashScope API 格式的媒體物件列表
    """
    media = []  # 最終要回傳的媒體列表
    for item in MEDIA_FILES:
        # 取得副檔名並轉為小寫，用於判斷檔案類型
        ext = os.path.splitext(item["path"])[1].lower()

        # 根據副檔名設定對應的 MIME 類型
        if ext in (".jpg", ".jpeg"):
            mime_type = "image/jpeg"
        elif ext == ".png":
            mime_type = "image/png"
        elif ext == ".webp":
            mime_type = "image/webp"
        elif ext == ".mp4":
            mime_type = "video/mp4"
        else:
            # 不支援的格式直接擲出例外
            raise ValueError(f"不支援的檔案格式: {ext}（支援: jpg, png, webp, mp4）")

        # 將檔案編碼為 Base64 字串（不含前綴）
        base64_str = file_to_base64(item["path"])

        # 組裝為 data URI 格式的 URL，這是 DashScope API 接受的內嵌媒體格式
        media.append({
            "type": item["type"],     # 保留原始的素材用途標記（如 first_frame）
            "url": f"data:{mime_type};base64,{base64_str}"  # data URI
        })
    return media


def print_create_response(response: requests.Response) -> None:
    """列印建立任務時伺服器回傳的初始回應內容。

    此函式會解析回應 JSON 並顯示：
      - HTTP 狀態碼（200 表示成功）
      - request_id（用於向官方回報問題時的追蹤 ID）
      - task_id（後續輪詢查詢狀態時的必要 ID）
      - task_status（初始狀態，通常為 PENDING）
      - usage 資訊（若有）
      - 錯誤碼與錯誤訊息（若非 200）

    參數:
        response : requests.Response 物件，來自 POST 請求的回應
    """
    print("\n" + "=" * 60)
    print("伺服器初始回應（建立任務）")
    print("=" * 60)
    print(f"  HTTP 狀態碼   : {response.status_code}")

    try:
        # 嘗試將回應內容解析為 JSON 字典
        body = response.json()

        # request_id：用於技術支援時追蹤請求的識別碼
        print(f"  request_id    : {body.get('request_id', 'N/A')}")

        # output 區塊包含任務的核心資訊
        output = body.get("output", {})
        print(f"  task_id       : {output.get('task_id', 'N/A')}")
        print(f"  task_status   : {output.get('task_status', 'N/A')}")

        # usage 區塊包含計費相關資訊（部分回應會預先返回）
        usage = body.get("usage", {})
        if usage:
            # json.dumps 確保將 usage 字典格式化為易讀的 JSON 字串
            # ensure_ascii=False 確保中文字元正常顯示
            print(f"  usage         : {json.dumps(usage, ensure_ascii=False)}")

        # 非 200 狀態碼時，顯示 API 回傳的錯誤詳情
        if response.status_code != 200:
            code = body.get("code", "")
            message = body.get("message", "")
            print(f"  錯誤碼        : {code}")
            print(f"  錯誤訊息      : {message}")
    except Exception:
        # 若 JSON 解析失敗（可能回應非 JSON 格式），直接顯示原始文字
        print(f"  原始回應體    : {response.text}")

    print("=" * 60)


def create_task() -> tuple:
    """向 DashScope API 提交視訊生成任務。

    此函式會：
      1. 根據使用者設定建構請求體（payload）
      2. 設定必要的 HTTP 標頭（非同步模式、認證、JSON 格式）
      3. 向 API 端點發送 POST 請求
      4. 呼叫 print_create_response 列印伺服器回應
      5. 返回 task_id 和 task_status

    回傳:
        tuple[str, str] — (task_id, task_status)
          task_id   : 任務的唯一識別碼，用於後續輪詢查詢
          task_status : 初始任務狀態，通常為 "PENDING"
    """
    # 建構請求體（payload）：遵循 DashScope 視訊合成 API 規範
    payload = {
        "model": MODEL_TYPE,           # 模型名稱
        "input": {
            "prompt": PROMPT,          # 文字提示詞
        },
        "parameters": PARAMS           # 生成參數（解析度、時長等）
    }
    # 注意：文生視訊模型（t2v）不需要 media 欄位
    # 若提交了 media 欄位反而可能導致 API 報錯
    if MODEL_TYPE != "happyhorse-1.0-t2v":
        payload["input"]["media"] = build_media_list()

    # HTTP 請求標頭設定：
    #   X-DashScope-Async : 必須設為 "enable"，表示使用非同步模式
    #     非同步模式下 API 會立即返回 task_id，後續需輪詢獲取結果
    #   Authorization     : Bearer Token 認證，格式為 "Bearer {API_KEY}"
    #   Content-Type       : 必須設為 "application/json"
    headers = {
        "X-DashScope-Async": "enable",
        "Authorization": f"Bearer {API_KEY}",
        "Content-Type": "application/json"
    }

    # 向 DashScope 視訊合成 API 端點發送 POST 請求
    response = requests.post(
        "https://dashscope.aliyuncs.com/api/v1/services/aigc/video-generation/video-synthesis",
        headers=headers,
        data=json.dumps(payload)  # 將 payload 序列化為 JSON 字串
    )

    # 始終列印伺服器回應內容供使用者確認
    print_create_response(response)

    # 判斷 HTTP 狀態碼決定後續處理
    if response.status_code == 200:
        output = response.json()["output"]
        return output["task_id"], output["task_status"]
    else:
        # 非 200 狀態碼表示請求失敗，擲出例外終止流程
        raise Exception(f"建立任務失敗，HTTP {response.status_code}")


def print_query_response(task_info: dict, retry_count: int, elapsed_sec: float) -> None:
    """列印每次輪詢查詢時伺服器回傳的完整資訊。

    每次呼叫 query_task_status 後，此函式會被呼叫以顯示：
      - 目前是第幾次輪詢，以及從任務提交後已等待的總時間
      - 任務 ID 與當前狀態
      - 提交時間、排程時間、完成時間
      - 成功時顯示視訊下載網址
      - 失敗時顯示錯誤碼與錯誤訊息
      - usage 計費資訊（若有返回）

    參數:
        task_info    : 從 query_task_status 回傳的任務資訊字典
        retry_count  : 目前輪詢次數（從 1 開始）
        elapsed_sec  : 從任務提交後已經過的秒數
    """
    # 將經過秒數格式化為人類易讀格式
    elapsed_str = format_elapsed(elapsed_sec)
    print("-" * 50)
    print(f"  第 {retry_count} 次輪詢  |  已等待 {elapsed_str}")
    print(f"  task_id         : {task_info.get('task_id', 'N/A')}")
    print(f"  task_status     : {task_info.get('status', 'N/A')}")
    print(f"  submit_time     : {task_info.get('submit_time', 'N/A')}")
    print(f"  scheduled_time  : {task_info.get('scheduled_time', 'N/A')}")
    print(f"  end_time        : {task_info.get('end_time', 'N/A')}")

    # 成功時顯示視訊下載網址（後續 24 小時內有效）
    if task_info.get("status") == "SUCCEEDED":
        print(f"  video_url       : {task_info.get('video_url', 'N/A')}")

    # 失敗時顯示錯誤詳情
    if task_info.get("status") == "FAILED":
        print(f"  error_code      : {task_info.get('error_code', 'N/A')}")
        print(f"  error_message   : {task_info.get('error_message', 'N/A')}")

    # usage 計費資訊（伺服器在任務完成後才會返回完整 usage）
    usage = task_info.get("usage", None)
    if usage:
        print(f"  usage           : {json.dumps(usage, ensure_ascii=False)}")
    print("-" * 50)


def query_task_status(task_id: str) -> dict:
    """查詢指定任務的目前狀態。

    使用 GET 方法請求 DashScope 任務查詢 API，
    將回應中的 output 和 usage 欄位解析為字典返回。

    參數:
        task_id : 建立任務時獲得的唯一識別碼

    回傳:
        dict — 包含以下鍵的任務資訊字典：
          "task_id"        : 任務 ID
          "status"         : 任務狀態（PENDING / RUNNING / SUCCEEDED / FAILED / UNKNOWN）
          "video_url"      : 視訊下載網址（僅 SUCCEEDED 時有效）
          "error_code"     : 錯誤碼（僅 FAILED 時有效）
          "error_message"  : 錯誤訊息（僅 FAILED 時有效）
          "submit_time"    : 任務提交時間
          "scheduled_time" : 任務排程時間
          "end_time"       : 任務完成時間
          "usage"          : 計費資訊（含 SR 解析度檔位與 duration 計費時長）
    """
    # 查詢任務時僅需要 Authorization 認證標頭
    headers = {
        "Authorization": f"Bearer {API_KEY}"
    }
    # 任務查詢端點格式：/api/v1/tasks/{task_id}
    url = f"https://dashscope.aliyuncs.com/api/v1/tasks/{task_id}"
    response = requests.get(url, headers=headers)

    if response.status_code == 200:
        # 成功回應：解析 JSON 並提取 output 和 usage 區塊
        body = response.json()
        output = body.get("output", {})
        usage = body.get("usage", {})
        return {
            "task_id": output.get("task_id", task_id),
            "status": output.get("task_status", "UNKNOWN"),
            "video_url": output.get("video_url", None),
            "error_code": output.get("code", None),
            "error_message": output.get("message", None),
            "submit_time": output.get("submit_time", "N/A"),
            "scheduled_time": output.get("scheduled_time", "N/A"),
            "end_time": output.get("end_time", "N/A"),
            "usage": usage if usage else None,
        }
    else:
        # 查詢失敗時擲出例外（如網路問題、認證過期等）
        raise Exception(f"查詢任務失敗: {response.text}")


def print_final_result(task_info: dict, elapsed_sec: float) -> None:
    """列印任務最終結果摘要，包含視訊網址和實際費用明細。

    此函式在任務狀態變為 SUCCEEDED 或 FAILED 時被呼叫，
    會彙總顯示：
      - 最終狀態與總耗時
      - 視訊下載網址（成功時）
      - 錯誤詳情（失敗時）
      - 各時間節點（提交、排程、完成）
      - 伺服器返回的 usage 計費資訊
      - 根據 usage 計算的實際費用（含單價、折扣明細）

    參數:
        task_info   : 從 query_task_status 回傳的任務資訊字典
        elapsed_sec : 從任務提交後已經過的秒數
    """
    print("\n" + "=" * 60)
    # 標題顯示總耗時
    print(f"最終任務結果  |  總耗時 {format_elapsed(elapsed_sec)}")
    print("=" * 60)

    # 根據任務狀態顯示對應資訊
    if task_info["status"] == "SUCCEEDED":
        print(f"  任務狀態        : SUCCEEDED（成功）")
        # video_url 有效期限為 24 小時，需在此期間內下載
        print(f"  視訊網址        : {task_info.get('video_url', 'N/A')}")
    elif task_info["status"] == "FAILED":
        print(f"  任務狀態        : FAILED（失敗）")
        print(f"  錯誤碼          : {task_info.get('error_code', 'N/A')}")
        print(f"  錯誤訊息        : {task_info.get('error_message', 'N/A')}")

    # 各時間節點：可用於分析任務排隊與執行耗時
    print(f"  提交時間        : {task_info.get('submit_time', 'N/A')}")
    print(f"  排程時間        : {task_info.get('scheduled_time', 'N/A')}")
    print(f"  完成時間        : {task_info.get('end_time', 'N/A')}")

    # --- 計費資訊與實際費用 ---
    usage = task_info.get("usage")
    if usage:
        # 從 usage 中提取解析度檔位（SR）和計費時長（duration）
        # SR 回傳的是純數字，如 720 或 1080
        sr = usage.get("SR", None)
        duration_actual = usage.get("duration", None)

        # 顯示伺服器返回的詳細 usage
        if sr is not None:
            print(f"  解析度檔位      : {sr}P")
        else:
            print(f"  解析度檔位      : N/A")
        if duration_actual is not None:
            print(f"  計費時長        : {duration_actual} 秒")
        else:
            print(f"  計費時長        : N/A")
        print(f"  完整 usage      : {json.dumps(usage, ensure_ascii=False)}")

        # 若伺服器提供了 SR 和 duration，則根據使用者設定的定價計算實際費用
        # 注意：實際帳單以阿里雲後台為準，此處僅供參考
        if sr is not None and duration_actual is not None:
            resolution_key = f"{sr}P"  # 組合為 "720P" 或 "1080P" 格式
            actual_cost = calc_cost(MODEL_TYPE, resolution_key, duration_actual)
            unit_price = PRICING.get(MODEL_TYPE, {}).get(resolution_key, 0)

            print(f"  單價            : {unit_price} 元/秒 ({resolution_key})")
            print(f"  計費時長        : {duration_actual} 秒")
            if DISCOUNT < 1.0:
                print(f"  折扣            : {DISCOUNT * 10:.0f} 折")
            print(f"  實際費用        : {actual_cost:.2f} 元")

    print("=" * 60)


def download_video(video_url: str, output_path: str = "output.mp4") -> str:
    """從伺服器下載生成的視訊並存入本地。

    下載時會自動嘗試從伺服器回應中取得正確的檔案名稱，優先順序為：
      1. Content-Disposition 回應標頭中的 filename 參數
      2. URL 路徑中的檔案名（去掉查詢參數）
      3. 使用傳入的 output_path 作為兜底檔案名

    參數:
        video_url   : 視訊的下載網址（來自 API 回應的 video_url 欄位）
        output_path : 兜底輸出檔案路徑，預設為 "output.mp4"

    回傳:
        str — 實際儲存的檔案路徑（可能與傳入的 output_path 不同）
    """
    # 使用 stream=True 以串流方式下載，避免大型檔案佔用過多記憶體
    response = requests.get(video_url, stream=True)

    if response.status_code == 200:
        # ── 步驟一：嘗試從 Content-Disposition 標頭取得伺服器指定的檔案名 ──
        cd = response.headers.get("Content-Disposition", "")
        if "filename=" in cd:
            # RFC 5987 編碼格式：filename*=UTF-8''%E6%AA%94%E6%A1%88.mp4
            if "filename*=UTF-8''" in cd:
                server_name = cd.split("UTF-8''")[-1].strip()
                # requests.utils.unquote 進行 URL 解碼（如 %20 → 空格）
                server_name = requests.utils.unquote(server_name).strip('"')
            else:
                # 傳統格式：filename="檔案.mp4" 或 filename=檔案.mp4
                server_name = cd.split("filename=")[-1].strip().strip('"').strip("'")
            # 若成功提取到非空檔案名，則使用伺服器指定的名稱
            if server_name:
                output_path = server_name
        else:
            # ── 步驟二：從 URL 路徑中提取檔案名 ──
            # 例如 https://example.com/path/video_abc.mp4?Expires=... → video_abc.mp4
            # urlparse 會將 URL 拆解為 scheme、host、path、query 等部分
            path = urlparse(video_url).path
            # 確認路徑不為空且最後一段包含副檔名（含有 "."）
            if "/" in path and "." in path.split("/")[-1]:
                output_path = path.split("/")[-1]

        # ── 步驟三：以二進位寫入模式儲存檔案 ──
        with open(output_path, "wb") as f:
            # iter_content 以區塊方式讀取回應內容，避免一次性載入整個檔案
            # chunk_size=1024 表示每次讀取 1KB
            for chunk in response.iter_content(chunk_size=1024):
                if chunk:  # 跳過空的區塊（保持回調）
                    f.write(chunk)

        print(f"視訊已儲存至: {output_path}")
        return output_path  # 回傳實際儲存路徑，供後續播放使用
    else:
        # 下載失敗（如 URL 已過期或網路問題）
        raise Exception(f"下載失敗，HTTP {response.status_code}")


def play_video_loop(file_path: str) -> None:
    """以循環模式播放指定的視訊檔案。

    會依序嘗試以下方式播放，並自動循環直到使用者手動關閉：
      1. mpv：使用 --loop-file=inf 參數無限循環
         安裝方式：winget install mpv 或從 https://mpv.io/ 下載
      2. ffplay（FFmpeg 附帶的播放器）：使用 -loop 0 參數無限循環
         安裝方式：winget install ffmpeg 或 https://ffmpeg.org/download.html
      3. VLC media player：使用 --loop 參數
         下載網址：https://www.videolan.org/vlc/
      4. 系統預設播放器：使用 os.startfile() 開啟（循環需手動設定）

    若以上播放器都不可用，則僅提示檔案路徑讓使用者手動開啟。

    參數:
        file_path : 要播放的視訊檔案路徑（絕對或相對路徑皆可）
    """
    abs_path = os.path.abspath(file_path)

    # ── 嘗試 1：mpv（支援 --loop-file=inf 無限循環）──
    if shutil.which("mpv"):
        print(f"\n使用 mpv 循環播放中…（按 Q 鍵或關閉視窗結束）")
        subprocess.run(
            ["mpv", "--loop-file=inf", "--no-terminal", abs_path],
            check=False
        )
        return

    # ── 嘗試 2：ffplay（FFmpeg 的輕量播放器）──
    if shutil.which("ffplay"):
        print(f"\n使用 ffplay 循環播放中…（按 Q 鍵或關閉視窗結束）")
        subprocess.run(
            ["ffplay", "-loop", "0", "-autoexit", "-loglevel", "quiet", abs_path],
            check=False
        )
        return

    # ── 嘗試 3：VLC media player ──
    if shutil.which("vlc"):
        print(f"\n使用 VLC 循環播放中…（關閉 VLC 視窗結束）")
        subprocess.run(
            ["vlc", "--loop", "--play-and-exit", abs_path],
            check=False
        )
        return

    # ── 嘗試 4：Windows 系統預設播放器 ──
    if os.name == "nt":
        print(f"\n使用系統預設播放器開啟…（請手動啟用循環/重複播放功能）")
        os.startfile(abs_path)
        return

    # ── 最後兜底：提示檔案路徑 ──
    print(f"\n找不到可用的播放器，請手動開啟以下檔案：")
    print(f"  {abs_path}")
    print(f"提示：安裝 mpv（推薦）、ffplay（FFmpeg）或 VLC 可支援自動循環播放。")


# =====================================================================================
# 第四節：主流程
# =====================================================================================

def main() -> None:
    """程式主入口。

    執行流程（無 EXISTING_TASK_ID）：
      1. 列印目前設定（讓使用者核對）
      2. 等待使用者按 Enter 鍵確認
      3. 校驗設定的合法性
      4. 向 API 提交視訊生成任務
      5. 定期輪詢查詢任務狀態，直到完成或失敗
      6. 下載生成的視訊

    執行流程（有 EXISTING_TASK_ID）：
      1. 列印目前設定
      2. 查詢既有任務狀態
      3. 若已完成則直接下載播放；若仍在進行則進入輪詢
      4. 下載生成的視訊
    """
    # ── 步驟一：列印使用者設定，供核對確認 ──
    print_configuration()

    if EXISTING_TASK_ID:
        # 使用已有的 task_id，跳過任務建立
        task_id = EXISTING_TASK_ID
        start_time = time.time()
        print(f"\n使用已有 task_id: {task_id}，直接開始輪詢...")

        # 先查詢一次，確認當前狀態
        task_info = query_task_status(task_id)
        print_query_response(task_info, 1, 0)

        if task_info["status"] == "SUCCEEDED":
            print_final_result(task_info, 0)
            saved_path = download_video(task_info["video_url"], OUTPUT_FILE)
            play_video_loop(saved_path)
            return
        elif task_info["status"] == "FAILED":
            print_final_result(task_info, 0)
            return
        elif task_info["status"] == "UNKNOWN":
            print("任務 ID 已過期（24 小時）或不存在，請檢查後重試。")
            return

        retry = 1
        video_url = None
    else:
        # ── 步驟二：暫停等待使用者確認 ──
        input("\n按 Enter 鍵開始提交任務...")

        # ── 步驟三：校驗設定 ──
        validate_config()

        # ── 步驟四：建立任務 ──
        task_id, initial_status = create_task()
        print(f"\n任務已提交，開始輪詢等待...")

        # 記錄任務提交的時間點，用於計算已等待時間
        start_time = time.time()

        retry = 0
        video_url = None

    # ── 步驟五：輪詢任務狀態 ──
    display_count = retry              # 顯示用的輪詢計數，始終遞增
    while retry < MAX_POLL_COUNT:
        # 等待 POLL_INTERVAL 秒後再查詢
        time.sleep(POLL_INTERVAL)
        display_count += 1
        # RUNNING 狀態不計入超時次數，僅在非 RUNNING 時遞增
        retry += 1

        # 計算從任務提交到現在已過去的秒數
        elapsed = time.time() - start_time

        # 查詢目前任務狀態
        task_info = query_task_status(task_id)

        # 列印本次輪詢的詳細回應
        print_query_response(task_info, display_count, elapsed)

        # 根據任務狀態決定後續動作
        if task_info["status"] == "SUCCEEDED":
            # 任務成功完成：記錄視訊網址並跳出輪詢迴圈
            video_url = task_info["video_url"]
            print_final_result(task_info, elapsed)
            break
        elif task_info["status"] == "FAILED":
            # 任務失敗：列印最終結果後終止程式
            print_final_result(task_info, elapsed)
            return
        elif task_info["status"] == "UNKNOWN":
            # 任務 ID 過期（24 小時後）或不存在
            # task_id 的有效查詢期限為 24 小時
            print("任務 ID 已過期（24 小時）或不存在，請重新提交。")
            return
        # PENDING 狀態繼續計入超時次數
        # RUNNING 狀態不計入超時次數，只要還在執行就永不超時
        if task_info["status"] == "RUNNING":
            retry -= 1

    # 輪詢次數用盡但視訊仍未生成
    if not video_url:
        print(f"\n任務逾時未完成（已輪詢 {display_count} 次共 {format_elapsed(time.time() - start_time)}），"
              f"請檢查參數設定或增大 MAX_POLL_COUNT 後重試。")
        return

    # ── 步驟六：下載視訊 ──
    # download_video 會自動從伺服器回應中選擇正確的檔案名
    # 回傳實際儲存路徑，供後續播放使用
    saved_path = download_video(video_url, OUTPUT_FILE)

    # ── 步驟七：循環播放 ──
    play_video_loop(saved_path)


# Python 程式的標準入口點
# 只有當此檔案被直接執行（而非被 import 時）才會執行 main()
if __name__ == "__main__":
    main()
