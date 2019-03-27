cp *.otf /usr/share/fonts/yashi/
chmod u+rwx /usr/share/fonts/yashi/*
cd /usr/share/fonts/yashi
mkfontscale
mkfontdir
fc-cache -fv


# 第一步：将windows下喜欢的字体文件copy到一个文件夹中，例如将XP里WINDOWS/FONTS中的字体文件，然后上传到linux服务器上，在linux中命名为xpfonts。

# 第二步：将copy到的字体文件夹copy到系统字体文件夹中并且修改权限
cp {存放xpfonts的路径}/xpfonts   /usr/share/fonts/
chmod u+rwx /usr/share/fonts/yashi/*

# 第三步：建立字体缓存
cd /usr/share/fonts/yashi
mkfontscale
mkfontdir
fc-cache -fv

# 这样就OK了，系统里面已经有了你想要的字体，这样用openoffice的时候再也不会遇到字体太少的尴尬了……如果看不到的话，shutdown -r now试一下。