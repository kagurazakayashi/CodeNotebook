# Windows安装CUDA驱动

## CUDA安装

<https://developer.nvidia.com/cuda-toolkit-archive>

1. 打开NVIDIA控制面板 > 系统信息 > 组件
2. 找 `NVCUDA64.DLL  32.0.15.6636  NVIDIA CUDA 12.7.33 driver`
3. 看后面找个版本号下载 =< 自己的版本的

## cuDNN 安装

<https://developer.nvidia.com/cudnn-downloads?target_os=Windows>

将下面的变量添加到环境变量里的系统变量path里面:

`C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v******\extras\demo_suite`
