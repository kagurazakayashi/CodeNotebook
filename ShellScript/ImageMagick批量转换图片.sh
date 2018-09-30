for img in `find ./ -name "*.bmp"`; do convert $img ${img/bmp}jpg; done
