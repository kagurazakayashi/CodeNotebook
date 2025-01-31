# svg转png

`npm install svg2png -g`

```bat
FOR %i in (*.svg) DO svg2png "%i" --output="%~ni.png" --width=1024 --height=1024
```

```bash
for file in *.svg; do svg2png "$file" --output="${file%%.*}.png" --width=1024 --height=1024; done
```
