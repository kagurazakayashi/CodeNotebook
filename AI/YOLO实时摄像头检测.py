# YOLO实时摄像头检测.py
# Windows + Ultralytics YOLO + OpenCV 实时摄像头检测
# 环境前置：pip install ultralytics opencv-python （已在上一条消息配置）

import argparse
import time
from pathlib import Path

import cv2
import torch
from ultralytics import YOLO


def parse_args():
    parser = argparse.ArgumentParser(
        description="YOLO 实时摄像头检测（Windows, OpenCV）"
    )
    parser.add_argument(
        "--model", type=str, default="yolov8n.pt",
        help="YOLO 权重文件（如 yolov8n.pt / yolov8s.pt / yolov10n.pt 等）"
    )
    parser.add_argument(
        "--cam", type=int, default=0,
        help="摄像头索引（0/1/2...，外接/内置不同设备可能不同）"
    )
    parser.add_argument(
        "--conf", type=float, default=0.25,
        help="置信度阈值（0~1）"
    )
    parser.add_argument(
        "--imgsz", type=int, default=640,
        help="推理输入分辨率（边长，常见 640/720/960/1280）"
    )
    parser.add_argument(
        "--width", type=int, default=1280,
        help="采集画面宽（尝试与你摄像头支持的最优分辨率匹配）"
    )
    parser.add_argument(
        "--height", type=int, default=720,
        help="采集画面高"
    )
    parser.add_argument(
        "--max-det", type=int, default=300,
        help="单帧最大检测目标数"
    )
    parser.add_argument(
        "--device", type=str, default="auto",
        help="设备选择：auto/cpu/cuda:0（若已装 GPU 版 PyTorch）"
    )
    parser.add_argument(
        "--save", action="store_true",
        help="将带框视频保存为 mp4 文件（与窗口同步）"
    )
    parser.add_argument(
        "--save-dir", type=str, default="runs/cam",
        help="保存目录（仅在 --save 时生效）"
    )
    parser.add_argument(
        "--window", type=str, default="YOLO-Cam",
        help="窗口标题"
    )
    return parser.parse_args()


def select_device(dev_str: str):
    if dev_str == "auto":
        return "cuda:0" if torch.cuda.is_available() else "cpu"
    return dev_str


def open_camera(index: int, width: int, height: int, window_title: str):
    # 使用 CAP_DSHOW 降低延迟并提高兼容性（Windows DirectShow）
    cap = cv2.VideoCapture(index, cv2.CAP_DSHOW)
    if not cap.isOpened():
        raise RuntimeError(
            f"无法打开摄像头 index={index}。"
            f" 请检查隐私权限、是否被其他软件占用，或尝试更换 --cam。"
        )

    # 尝试设置分辨率（不是所有摄像头都支持，失败会自动回落）
    cap.set(cv2.CAP_PROP_FRAME_WIDTH, width)
    cap.set(cv2.CAP_PROP_FRAME_HEIGHT, height)

    # 可选：尝试 MJPG 提升帧率与延迟表现（不支持则忽略）
    cap.set(cv2.CAP_PROP_FOURCC, cv2.VideoWriter_fourcc(*"MJPG"))

    # 预创建窗口（便于后续 setWindowProperty 等扩展）
    cv2.namedWindow(window_title, cv2.WINDOW_NORMAL)
    return cap


def init_writer(save_dir: Path, fps: float, width: int, height: int):
    save_dir.mkdir(parents=True, exist_ok=True)
    ts = time.strftime("%Y%m%d-%H%M%S")
    out_path = save_dir / f"YOLO实时摄像头检测_{ts}.mp4"
    writer = cv2.VideoWriter(
        str(out_path),
        cv2.VideoWriter_fourcc(*"mp4v"),
        fps,
        (width, height),
    )
    if not writer.isOpened():
        raise RuntimeError("VideoWriter 打开失败，无法保存视频。")
    return writer, out_path


def main():
    args = parse_args()
    device = select_device(args.device)

    print(f"[INFO] 加载模型：{args.model}")
    model = YOLO(args.model)
    # 可选：融合卷积与 BN，改善推理速度（部分模型支持）
    try:
        model.fuse()
    except Exception:
        pass

    # 打开摄像头
    cap = open_camera(args.cam, args.width, args.height, args.window)

    # 确认实际捕获分辨率（摄像头可能降级）
    real_w = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
    real_h = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
    print(f"[INFO] 采集分辨率：{real_w}x{real_h}")
    print(f"[INFO] 推理设备：{device} | PyTorch CUDA 可用={torch.cuda.is_available()}")

    # 预热一帧（降低首帧延迟）
    _ = cap.read()

    # 可选：估计 FPS 用于保存视频的帧率（先默认 30）
    est_fps = cap.get(cv2.CAP_PROP_FPS)
    if not est_fps or est_fps <= 0:
        est_fps = 30.0

    writer = None
    out_path = None
    if args.save:
        writer, out_path = init_writer(Path(args.save_dir), est_fps, real_w, real_h)
        print(f"[INFO] 保存至：{out_path}")

    # EMA 平滑 FPS
    ema_fps = None
    t_prev = time.perf_counter()

    try:
        while True:
            ok, frame = cap.read()
            if not ok:
                print("[WARN] 读取帧失败，尝试继续...")
                continue

            t0 = time.perf_counter()

            # 执行推理；verbose=False 以减少控制台噪声
            results = model.predict(
                frame,
                conf=args.conf,
                imgsz=args.imgsz,
                device=device,
                max_det=args.max_det,
                verbose=False,
            )
            # 绘制检测框
            annotated = results[0].plot()

            # 计算 FPS（EMA）
            t1 = time.perf_counter()
            inst_fps = 1.0 / max(t1 - t0, 1e-6)
            if ema_fps is None:
                ema_fps = inst_fps
            else:
                ema_fps = ema_fps * 0.8 + inst_fps * 0.2

            # 叠加状态文本
            hud = f"{Path(args.model).stem} | {device} | {ema_fps:5.1f} FPS | conf={args.conf} | imgsz={args.imgsz}"
            cv2.putText(
                annotated, hud, (12, 28),
                cv2.FONT_HERSHEY_SIMPLEX, 0.7, (255, 255, 255), 2, cv2.LINE_AA
            )

            # 显示
            cv2.imshow(args.window, annotated)

            # 可选保存
            if writer is not None:
                # 若推理后的分辨率与 writer 不匹配，需 resize
                if annotated.shape[1] != real_w or annotated.shape[0] != real_h:
                    annotated = cv2.resize(annotated, (real_w, real_h))
                writer.write(annotated)

            # 退出：Esc 或 q
            key = cv2.waitKey(1) & 0xFF
            if key in (27, ord('q')):
                break

            # 打印循环速率（可选）
            # print(f"[DBG] loop {1.0/(time.perf_counter()-t_prev):.1f} Hz")
            t_prev = time.perf_counter()

    except KeyboardInterrupt:
        print("\n[INFO] 捕获 Ctrl+C，准备退出...")
    finally:
        cap.release()
        if writer is not None:
            writer.release()
            print(f"[INFO] 已保存视频：{out_path}")
        cv2.destroyAllWindows()
        print("[INFO] 资源已释放。")


if __name__ == "__main__":
    main()
