# 去除png透明空边（当前文件夹所有png）
import os
from PIL import Image

def remove_whitespace_from_all_pngs_in_folder(folder_path):
    # 创建存放处理后文件的文件夹
    output_folder = os.path.join(folder_path, "trimmed_pngs")
    os.makedirs(output_folder, exist_ok=True)

    # 遍历当前文件夹中的所有 PNG 文件
    for filename in os.listdir(folder_path):
        if filename.lower().endswith(".png"):  # 仅处理 PNG 文件
            input_path = os.path.join(folder_path, filename)
            output_path = os.path.join(output_folder, filename)  # 保存到新文件夹
            remove_whitespace(input_path, output_path)

def remove_whitespace(input_path, output_path):
    try:
        # 打开图片
        image = Image.open(input_path)
        # 转为RGBA格式，确保透明度处理正确
        image = image.convert("RGBA")
        
        # 获取非空白区域的边界
        bbox = image.getbbox()
        
        if bbox:
            # 裁剪图片到非空白区域
            cropped_image = image.crop(bbox)
            # 保存处理后的图片
            cropped_image.save(output_path)
            print(f"处理完成: {input_path} -> {output_path}")
        else:
            print(f"图片 {input_path} 可能是完全透明的或没有内容")
    except Exception as e:
        print(f"处理 {input_path} 时发生错误: {e}")

# 使用示例
current_folder = os.getcwd()  # 获取当前文件夹路径
remove_whitespace_from_all_pngs_in_folder(current_folder)
