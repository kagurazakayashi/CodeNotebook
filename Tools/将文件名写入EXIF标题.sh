for file in *.jpg
do
    echo "$file" - "${file%.*}"
    exiftool -title="${file%.*}" "$file"
done
for file in *.JPG
do
    echo "$file" - "${file%.*}"
    exiftool -title="${file%.*}" "$file"
done
for file in *.png
do
    echo "$file" - "${file%.*}"
    exiftool -title="${file%.*}" "$file"
done
for file in *.PNG
do
    echo "$file" - "${file%.*}"
    exiftool -title="${file%.*}" "$file"
done