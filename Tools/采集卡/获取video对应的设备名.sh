# 获取video对应的设备名
for dev in /dev/video*; do
    echo "=== $dev ==="
    udevadm info --query=all --name="$dev" | grep -E 'ID_MODEL=|ID_MODEL_FROM_DATABASE=|ID_VENDOR=|V4L|DEVNAME'
    echo
done
