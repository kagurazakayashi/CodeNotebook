cp *.otf /usr/share/fonts/yashi/
chmod u+rwx /usr/share/fonts/yashi/*
cd /usr/share/fonts/yashi
mkfontscale
mkfontdir
fc-cache -fv
