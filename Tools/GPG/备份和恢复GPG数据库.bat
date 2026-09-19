title 备份和恢复GPG数据库
cd %APPDATA%\gnupg
gpg --export-ownertrust > B:\gpgdb.txt
xz -z -e -9 B:\gpgdb.txt
del trustdb.gpg
gpg --import-ownertrust < B:\gpgdb.txt
