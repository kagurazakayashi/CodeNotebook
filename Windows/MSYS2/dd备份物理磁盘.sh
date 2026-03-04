ls -lh /dev/disk/by-id/
# lrwxrwxrwx 1 yashi None 0 Jun  3 19:00 raid-ST2000LM003_HN-M201RAD_S37EJ9AH300548 -> ../../sde

dd if=/dev/sde bs=4M status=progress | nice -n 19 xz -z -9 -e --lzma2 --block-size=512M --threads=16 --memlimit=30G --keep --verbose > /d/2t.img.xz
