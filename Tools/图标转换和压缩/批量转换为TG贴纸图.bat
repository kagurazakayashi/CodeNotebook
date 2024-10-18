for %%i in (*.jpg) do (
    magick "%%i" -resize 513x513^ "resized_%%~ni.png"
    magick "resized_%%~ni.png" -gravity center -crop 512x512+0+0 +repage "%%~ni_512x512.png"
    del "resized_%%~ni.png"
	del "%%i"
)

for %%i in (*.jpg) do (
    magick "%%i" -resize 512x512^ "%%~ni_512x512.png"
	del "%%i"
)
