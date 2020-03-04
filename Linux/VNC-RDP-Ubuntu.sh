apt update
apt install vnc4server -y
apt install x-window-system-core -y
apt install gdm -y
apt install ubuntu-desktop -y
apt install gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal -y

vi ~/.vnc/xstartup
#!/bin/sh
# Uncomment the following two lines for normal desktop:
export XKL_XMODMAP_DISABLE=1
 unset SESSION_MANAGER
# exec /etc/X11/xinit/xinitrc
unset DBUS_SESSION_BUS_ADDRESS
gnome-panel &
gnome-settings-daemon &
metacity &
nautilus &
gnome-terminal &

vi /etc/systemd/system/vncserver@.service
[Unit]
Description=Remote Desktop VNC Service
After=syslog.target network.target
[Service]
Type=forking
WorkingDirectory=/home/ubuntu
User=ubuntu
Group=ubuntu
ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'
ExecStart=/usr/bin/vncserver -localhost no -geometry 1280x720
ExecStop=/usr/bin/vncserver -kill %i
[Install]
WantedBy=multi-user.target

# 语言支持
apt install libreoffice-l10n-zh-cn fcitx-chewing firefox-locale-zh-hant libreoffice-l10n-en-gb thunderbird-locale-zh-tw ibus-table-cangjie3 thunderbird-locale-zh-hans gnome-user-docs-zh-hans fcitx-ui-qimpanel libreoffice-help-zh-cn libreoffice-l10n-en-za language-pack-gnome-en thunderbird-locale-en-gb language-pack-gnome-zh-hans hyphen-en-ca thunderbird-locale-en fcitx-module-cloudpinyin ibus-libpinyin hyphen-en-us hunspell-en-gb hunspell-en-ca gnome-getting-started-docs-zh-hk thunderbird-locale-zh-cn thunderbird-locale-zh-hant libreoffice-help-en-us fonts-noto-cjk-extra mythes-en-au fonts-arphic-ukai language-pack-en hunspell-en-au fcitx-sunpinyin gnome-getting-started-docs-zh-tw ibus-chewing libreoffice-help-zh-tw fcitx-table-wubi firefox-locale-en ibus-table-cangjie5 hunspell-en-za thunderbird-locale-en-us hyphen-en-gb mythes-en-us firefox-locale-zh-hans language-pack-zh-hans libreoffice-l10n-zh-tw wbritish language-pack-gnome-zh-hant fonts-arphic-uming ibus-table-quick-classic libreoffice-help-en-gb -y