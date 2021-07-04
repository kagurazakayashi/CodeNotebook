vi /etc/passwd
guest:x:1003:1003::/home/guest:/bin/rbash

setfacl -R -m u:guest:- /usr/bin/*
setfacl -R -m u:guest:- /mnt/data
setfacl -R -m u:guest:- /etc/*
setfacl -R -m u:guest:rx /usr/bin/rbash
setfacl -R -m u:guest:rx /usr/bin/w3m
setfacl -R -m u:guest:rx /usr/bin/clear
setfacl -R -m u:guest:rx /etc/*

mkdir /home/guest/r
ln -s /usr/bin/lynx /home/guest/r/lynx
ln -s /usr/bin/clear /home/guest/r/clear
ln -s /usr/bin/rbash /home/guest/r/rbash
chown -R guest /home/guest/r

vi /home/guest/.bash_profile
#$PATH:$HOME/.local/bin:$HOME/bin
export PATH=$HOME/r
export PS1='Yashi End-User Session >'
clear
lynx http://www.yoooooooooo.com/yashi/yashitelnet/
clear
echo "[KagurazakaYashi's personal website] See you next time."
logout