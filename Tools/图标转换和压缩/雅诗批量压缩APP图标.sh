#!/bin/sh
# by 神楽坂雅詩
# 在当前文件夹准备好 icon.png
# Android
mkdir AndroidIcons
mkdir AndroidIcons/mipmap-mdpi
convert icon.png -resize 48x48 AndroidIcons/mipmap-mdpi/ic_launcher.png
convert -size 48x48 xc:none -fill AndroidIcons/mipmap-mdpi/ic_launcher.png -draw "circle 24,24 0,24" AndroidIcons/mipmap-mdpi/ic_launcher_round.png
mkdir AndroidIcons/mipmap-hdpi
convert icon.png -resize 72x72 AndroidIcons/mipmap-hdpi/ic_launcher.png
convert -size 72x72 xc:none -fill AndroidIcons/mipmap-hdpi/ic_launcher.png -draw "circle 36,36 0,36" AndroidIcons/mipmap-hdpi/ic_launcher_round.png
mkdir AndroidIcons/mipmap-xhdpi
convert icon.png -resize 96x96 AndroidIcons/mipmap-xhdpi/ic_launcher.png
convert -size 96x96 xc:none -fill AndroidIcons/mipmap-xhdpi/ic_launcher.png -draw "circle 48,48 0,48" AndroidIcons/mipmap-xhdpi/ic_launcher_round.png
mkdir AndroidIcons/mipmap-xxhdpi
convert icon.png -resize 144x144 AndroidIcons/mipmap-xxhdpi/ic_launcher.png
convert -size 144x144 xc:none -fill AndroidIcons/mipmap-xxhdpi/ic_launcher.png -draw "circle 72,72 0,72" AndroidIcons/mipmap-xxhdpi/ic_launcher_round.png
mkdir AndroidIcons/mipmap-xxxhdpi
convert icon.png -resize 192x192 AndroidIcons/mipmap-xxxhdpi/ic_launcher.png
convert -size 192x192 xc:none -fill AndroidIcons/mipmap-xxxhdpi/ic_launcher.png -draw "circle 96,96 0,96" AndroidIcons/mipmap-xxxhdpi/ic_launcher_round.png
# iOS
mkdir AppIcon.appiconset
convert icon.png -resize 20x20 AppIcon.appiconset/Icon-App-20x20@1x.png
convert icon.png -resize 29x29 AppIcon.appiconset/Icon-App-29x29@1x.png
convert icon.png -resize 40x40 AppIcon.appiconset/Icon-App-20x20@2x.png
convert icon.png -resize 58x58 AppIcon.appiconset/Icon-App-29x29@2x.png
convert icon.png -resize 60x60 AppIcon.appiconset/Icon-App-20x20@3x.png
convert icon.png -resize 76x76 AppIcon.appiconset/Icon-App-76x76@1x.png
convert icon.png -resize 87x87 AppIcon.appiconset/Icon-App-87x87@1x.png
convert icon.png -resize 80x80 AppIcon.appiconset/Icon-App-20x20@4x.png
convert icon.png -resize 120x120 AppIcon.appiconset/Icon-App-20x20@6x.png
convert icon.png -resize 152x152 AppIcon.appiconset/Icon-App-76x76@2x.png
convert icon.png -resize 167x167 AppIcon.appiconset/Icon-App-83.5x83.5@2x.png
convert icon.png -resize 180x180 AppIcon.appiconset/Icon-App-20x20@9x.png
convert icon.png -resize 1024x1024 AppIcon.appiconset/Icon-App-1024x1024@1x.png
cp Contents.json AppIcon.appiconset/Contents.json