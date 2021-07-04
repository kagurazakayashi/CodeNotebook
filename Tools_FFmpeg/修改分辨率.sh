ffmpeg -i 2019-01-20-ROC-MEXICO-A.MP4 -vf scale=1280:720 2019-01-20-ROC-MEXICO-A-720P.MP4 -hide_banner

# 把高清格式（1920x1080像素）的视频分辨率降低到640x360（这是一种相当常用的纵横比16:9配置）：
ffmpeg -i video_1920.mp4 -vf scale=640:360 video_640.mp4 -hide_banner
# 如果我们想改变视频的外观，知道图像会出现失真，我们可以使用一个额外的过滤器“setdar”。假设在前一种情况下，我们希望将16:9纵横比更改为4:3，因此视频的分辨率为4:3纵横比，在本例中为640x480。进行此转换的ffmpeg命令是：
ffmpeg -i video_1920.mp4 -vf scale=640:480,setdar=4:3 video_640x480.mp4 -hide_banner
# 另一方面，如果我们不想依赖于使用可能“更正常”的纵横比（4:3，16:9），或者如果我们想更改具有未定义纵横比的其他分辨率，并且我们不害怕可能出现的图像变形，我们可以使用“setsar”过滤器，这样可以避免您不得不保留这些纵横比。通过这种方式，我们可以将以前的视频转换为200x400的分辨率，例如，使用以下命令：
ffmpeg -i video_1920.mp4 -vf scale=200:400,setsar=1:1 video_200x400.mp4 -hide_banner
# 正如我们之前看到的，我们可以将视频大小调整到原来的一半。我们使用以下命令将其从320x180像素分辨率调整为160x90像素分辨率：
ffmpeg -i video_320x180.mp4 -vf scale=160:90 video_180x90.mp4 -hide_banner
# 现在让我们将原始视频纵横比从16:9更改为4:3。为此，我们使用以下命令将视频大小从320x180调整为320x240：
ffmpeg -i video_320x180.mp4 -vf scale=320:240,setdar=4:3 video_320x240.mp4 -hide_banner
# 现在，我们将调整视频的大小，就像它必须适应垂直屏幕一样，所以我们将从320x180像素调整到180x320像素。下面是执行任务的命令：
ffmpeg -i video_320x180.mp4 -vf scale=180:320,setsar=1:1 video_180x320.mp4 -hide_banner