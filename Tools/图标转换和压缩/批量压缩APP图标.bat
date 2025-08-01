@REM \\bin\\sh
@REM by 神楽坂雅詩
@REM 在当前文件夹准备好 icon.png
@REM Android
mkdir AndroidIcons
mkdir AndroidIcons\\mipmap-mdpi
magick icon.png -alpha remove -alpha off -resize 48x48 AndroidIcons\\mipmap-mdpi\\ic_launcher.png
magick -size 48x48 xc:none -fill AndroidIcons\\mipmap-mdpi\\ic_launcher.png -draw "circle 24,24 0,24" "AndroidIcons\\mipmap-mdpi\\ic_launcher_round.png"
mkdir AndroidIcons\\mipmap-hdpi
magick icon.png -alpha remove -alpha off -resize 72x72 AndroidIcons\\mipmap-hdpi\\ic_launcher.png
magick -size 72x72 xc:none -fill AndroidIcons\\mipmap-hdpi\\ic_launcher.png -draw "circle 36,36 0,36" "AndroidIcons\\mipmap-hdpi\\ic_launcher_round.png"
mkdir AndroidIcons\\mipmap-xhdpi
magick icon.png -alpha remove -alpha off -resize 96x96 AndroidIcons\\mipmap-xhdpi\\ic_launcher.png
magick -size 96x96 xc:none -fill AndroidIcons\\mipmap-xhdpi\\ic_launcher.png -draw "circle 48,48 0,48" "AndroidIcons\\mipmap-xhdpi\\ic_launcher_round.png"
mkdir AndroidIcons\\mipmap-xxhdpi
magick icon.png -alpha remove -alpha off -resize 144x144 AndroidIcons\\mipmap-xxhdpi\\ic_launcher.png
magick -size 144x144 xc:none -fill AndroidIcons\\mipmap-xxhdpi\\ic_launcher.png -draw "circle 72,72 0,72" "AndroidIcons\\mipmap-xxhdpi\\ic_launcher_round.png"
mkdir AndroidIcons\\mipmap-xxxhdpi
magick icon.png -alpha remove -alpha off -resize 192x192 AndroidIcons\\mipmap-xxxhdpi\\ic_launcher.png
magick -size 192x192 xc:none -fill AndroidIcons\\mipmap-xxxhdpi\\ic_launcher.png -draw "circle 96,96 0,96" "AndroidIcons\\mipmap-xxxhdpi\\ic_launcher_round.png"
@REM iOS
mkdir AppIcon.appiconset
magick icon.png -alpha remove -alpha off -resize 20x20 AppIcon.appiconset\\Icon-App-20x20@1x.png
magick icon.png -alpha remove -alpha off -resize 29x29 AppIcon.appiconset\\Icon-App-29x29@1x.png
magick icon.png -alpha remove -alpha off -resize 40x40 AppIcon.appiconset\\Icon-App-20x20@2x.png
copy "AppIcon.appiconset\\Icon-App-20x20@2x.png" "AppIcon.appiconset\\Icon-App-40x40@1x.png"
magick icon.png -alpha remove -alpha off -resize 58x58 AppIcon.appiconset\\Icon-App-29x29@2x.png
magick icon.png -alpha remove -alpha off -resize 60x60 AppIcon.appiconset\\Icon-App-20x20@3x.png
magick icon.png -alpha remove -alpha off -resize 76x76 AppIcon.appiconset\\Icon-App-76x76@1x.png
magick icon.png -alpha remove -alpha off -resize 80x80 AppIcon.appiconset\\Icon-App-40x40@2x.png
magick icon.png -alpha remove -alpha off -resize 87x87 AppIcon.appiconset\\Icon-App-29x29@3x.png
copy "AppIcon.appiconset\\Icon-App-29x29@3x.png" "AppIcon.appiconset\\Icon-App-87x87@1x.png"
magick icon.png -alpha remove -alpha off -resize 80x80 AppIcon.appiconset\\Icon-App-20x20@4x.png
magick icon.png -alpha remove -alpha off -resize 120x120 AppIcon.appiconset\\Icon-App-20x20@6x.png
copy "AppIcon.appiconset\\Icon-App-20x20@6x.png" "AppIcon.appiconset\\Icon-App-40x40@3x.png"
copy "AppIcon.appiconset\\Icon-App-20x20@6x.png" "AppIcon.appiconset\\Icon-App-60x60@2x.png"
magick icon.png -alpha remove -alpha off -resize 152x152 AppIcon.appiconset\\Icon-App-76x76@2x.png
magick icon.png -alpha remove -alpha off -resize 167x167 AppIcon.appiconset\\Icon-App-83.5x83.5@2x.png
magick icon.png -alpha remove -alpha off -resize 180x180 AppIcon.appiconset\\Icon-App-20x20@9x.png
copy "AppIcon.appiconset\\Icon-App-20x20@9x.png" "AppIcon.appiconset\\Icon-App-60x60@3x.png"
magick icon.png -alpha remove -alpha off -resize 1024x1024 AppIcon.appiconset\\Icon-App-1024x1024@1x.png
copy "Contents.json" "AppIcon.appiconset\\Contents.json"