git clone https://github.com/gpac/gpac.git
cd gpac
git pull
./configure --static-mp4box --use-zlib=no
make
make install
MP4Box -cat a.mp4 -cat a.aac ab.mp4
