cd /d D:\yolo
py -3.11 -m venv .venv311
.\.venv311\Scripts\activate
python -V
python -m pip install -U pip setuptools wheel

@REM CPU
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

@REM GPU
nvidia-smi
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126

@REM YOLO & CAM
pip install ultralytics opencv-python

@REM （可选）为将来部署预埋组件(CPU/GPU)
pip install onnx onnxruntime
pip install onnxruntime-gpu


python YOLO实时摄像头检测.py --cam 2 --device cuda:0 --model yolov8n.pt --imgsz 1088 --width 1920 --height 1080 --conf 0.2
