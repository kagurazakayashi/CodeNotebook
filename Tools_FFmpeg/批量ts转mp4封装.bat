for %i in (*.ts) do ( ffmpeg -i %i -c copy -map 0:v -map 0:a %~ni.mp4 )