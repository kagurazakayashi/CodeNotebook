mkdir AndroidIcons
mkdir AndroidIcons/mipmap-mdpi
convert icon.png -resize 48x48 AndroidIcons/mipmap-mdpi/ic_launcher.png
mkdir AndroidIcons/mipmap-hdpi
convert icon.png -resize 72x72 AndroidIcons/mipmap-hdpi/ic_launcher.png
mkdir AndroidIcons/mipmap-xhdpi
convert icon.png -resize 96x96 AndroidIcons/mipmap-xhdpi/ic_launcher.png
mkdir AndroidIcons/mipmap-xxhdpi
convert icon.png -resize 144x144 AndroidIcons/mipmap-xxhdpi/ic_launcher.png
mkdir AndroidIcons/mipmap-xxxhdpi
convert icon.png -resize 192x192 AndroidIcons/mipmap-xxxhdpi/ic_launcher.png
mkdir AppIcon.appiconset
convert icon.png -resize 20x20 AppIcon.appiconset/Icon-App-20x20@1x.png
convert icon.png -resize 40x40 AppIcon.appiconset/Icon-App-20x20@2x.png
convert icon.png -resize 60x60 AppIcon.appiconset/Icon-App-20x20@3x.png
convert icon.png -resize 29x29 AppIcon.appiconset/Icon-App-29x29@1x.png
convert icon.png -resize 58x58 AppIcon.appiconset/Icon-App-29x29@2x.png
convert icon.png -resize 87x87 AppIcon.appiconset/Icon-App-29x29@3x.png
convert icon.png -resize 40x40 AppIcon.appiconset/Icon-App-40x40@1x.png
convert icon.png -resize 80x80 AppIcon.appiconset/Icon-App-40x40@2x.png
convert icon.png -resize 120x120 AppIcon.appiconset/Icon-App-40x40@3x.png
convert icon.png -resize 120x120 AppIcon.appiconset/Icon-App-60x60@2x.png
convert icon.png -resize 180x180 AppIcon.appiconset/Icon-App-60x60@3x.png
convert icon.png -resize 76x76 AppIcon.appiconset/Icon-App-76x76@1x.png
convert icon.png -resize 152x152 AppIcon.appiconset/Icon-App-76x76@2x.png
convert icon.png -resize 167x167 AppIcon.appiconset/Icon-App-83.5x83.5@2x.png
convert icon.png -resize 1024x1024 AppIcon.appiconset/Icon-App-1024x1024@1x.png
