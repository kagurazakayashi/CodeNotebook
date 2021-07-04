vim ~/.Xresources

ckground: black
XTerm*background: black
XTerm*Foreground: gray
XTerm*locale: true
XTerm*utf8Title: true
XTerm.cjkWidth:true
XTerm*saveLines: 4096
XTerm*scrollbar: yes
XTerm*faceName: Source Code Pro
XTerm*faceSize: 12

vim ~/.xinitrc

xrdb -merge ~/.Xresources
# exec dwm