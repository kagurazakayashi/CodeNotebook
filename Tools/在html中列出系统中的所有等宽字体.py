# 在 html 中列出系统中的所有等宽字体
# by 神楽坂雅詩

import os
import string
from PIL import ImageFont # pip install pillow
from fontTools.ttLib import TTFont # pip install fonttools

def font_supports_chinese(font_path):
    # 定义中文Unicode区块
    chinese_unicode_ranges = [
        (0x4E00, 0x9FFF),  # 基本汉字
        (0x3400, 0x4DBF),  # 扩展A
        (0x20000, 0x2A6DF),  # 扩展B
        (0x2A700, 0x2B73F),  # 扩展C
        (0x2B740, 0x2B81F),  # 扩展D
        (0x2B820, 0x2CEAF),  # 扩展E
        (0x2CEB0, 0x2EBEF),  # 扩展F
        (0x30000, 0x3134F),  # 扩展G
    ]

    try:
        font = TTFont(font_path)
        for table in font['cmap'].tables:
            for start, end in chinese_unicode_ranges:
                for codepoint in range(start, end + 1):
                    if table.cmap.get(codepoint):
                        return True  # 找到支持的中文字符
        return False  # 未找到支持的中文字符
    except Exception as e:
        print(f"Error checking font {font_path}: {e}")
        return False

def get_font_name(font_path):
    try:
        # 使用fontTools打开字体文件
        font = TTFont(font_path)
        # 读取字体名称。这里我们尝试读取全名，如果不可用，则回退到其他名称。
        name = ""
        for record in font['name'].names:
            if record.nameID == 4 and not name:  # 完整字体名称
                name = record.toUnicode()
                break
            elif record.nameID == 1 and not name:  # 字体家族名称
                name = record.toUnicode()
        return name
    except Exception as e:
        print(f"加载字体 {font_path} 失败: {e}")
        return None

def chars():
    # Initialize the target string
    target_string = ""

    # Loop through uppercase letters, lowercase letters, and numbers and add them to the string
    for char in string.ascii_uppercase:
        target_string += char

    for char in string.ascii_lowercase:
        target_string += char

    for number in range(10):
        target_string += str(number)
        
    return target_string

def is_monospaced_font(font_path, chk_chars, font_size=12):
    try:
        font = ImageFont.truetype(font_path, font_size)
        chars_to_check = chk_chars
        widths = [font.getbbox(char)[2] - font.getbbox(char)[0] for char in chars_to_check]
        return len(set(widths)) == 1
    except Exception as e:
        # print(f"Error checking font {font_path}: {e}")
        return False

fonts_dir = 'C:\\Windows\\Fonts'
with open('fonts.html', 'w', encoding='utf-8') as f:
    f.write('<!DOCTYPE html><html lang="zh-CN"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui:ios"><meta http-equiv="X-UA-Compatible" content="ie=edge"><title>字体</title></head><body>')
    for font_file in os.listdir(fonts_dir):
        font_path = os.path.join(fonts_dir, font_file)
        if font_path.lower().endswith('.ttf') or font_path.lower().endswith('.otf'):
            font_name = get_font_name(font_path)
            isMono = is_monospaced_font(font_path, chk_chars=chars())
            isMonoZh = is_monospaced_font(font_path, chk_chars="中文等宽字体测试")
            isChinese = font_supports_chinese(font_path)
            if isChinese and isMonoZh:
                f.write(f"<p>{font_name} (<code>{font_file}</code>) [中文等宽]</p>")
                f.write(f"<h1 style=\"font-family: '{font_name}';\">{chars()+"中文等宽"}</h1>")
                print(f"{font_name} ({font_file}) [中文等宽]")
            elif isMono:
                f.write(f"<p>{font_name} (<code>{font_file}</code>) [等宽]</p>")
                f.write(f"<h1 style=\"font-family: '{font_name}';\">{chars()}</h1>")
                print(f"{font_name} ({font_file}) [等宽]")
            # else:
                # print(f"{font_name} ({font_file}) 不是等宽字体。")
    f.write('</body></html>')