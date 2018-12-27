#Windows
echo Hello | clip
dir | clip
clip < README.TXT
echo | clip

#Ubuntu
echo "Hello, world" | xclip
echo "Hello, world" | xclip -selection clipboard
xclip -sel clip < file

#Linux
cat README.TXT | xsel
cat README.TXT | xsel -b
xsel < README.TXT
xsel -c

#Mac
echo 'Hello World!' | pbcopy
cat myFile.txt | pbcopy
pbpaste > file.txt
pbcopy < ~/.ssh/id_rsa.pub
