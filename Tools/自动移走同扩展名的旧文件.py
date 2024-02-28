# 监视文件夹，如果有一个以上的 .avi 文件，移走旧的
import os
import shutil
import time
from datetime import datetime
from tqdm import tqdm  # pip install tqdm

# 1024 * 1024 = 1KB * 1024 = 1M
def copy_with_progress(src, dest, buffer_size=1024*1024*1024):
    with open(src, 'rb') as fsrc, open(dest, 'wb') as fdst, tqdm(total=os.path.getsize(src), unit='B', unit_scale=True) as pbar:
        while True:
            buf = fsrc.read(buffer_size)
            if not buf:
                break
            fdst.write(buf)
            pbar.update(len(buf))

def move_with_progress(src, dest):
    os.makedirs(os.path.dirname(dest), exist_ok=True)
    copy_with_progress(src, dest)
    os.remove(src)

def move_oldest_avi():
    target_folder = "D:\\REC\\"
    if not os.path.exists(target_folder):
        os.makedirs(target_folder)
    avi_files = [f for f in os.listdir('.') if f.endswith('.avi')]
    if len(avi_files) <= 1:
        print("No .avi files found or there's only one .avi file.")
        return
    oldest_file = None
    oldest_time = datetime.max
    for file in avi_files:
        file_time = datetime.fromtimestamp(os.path.getmtime(file))
        if file_time < oldest_time:
            oldest_time = file_time
            oldest_file = file
    if oldest_file:
        print(f"Moving {oldest_file} to {target_folder}")
        move_with_progress(oldest_file, os.path.join(target_folder, oldest_file))

try:
    # 循环监控设置
    while True:
        move_oldest_avi()
        print("Waiting for the next check...")
        time.sleep(3)  # 等待时间，单位为秒（这里设置为5分钟）
except KeyboardInterrupt:
    print("\nProgram exited by user.")
