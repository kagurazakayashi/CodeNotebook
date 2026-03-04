# 从设备型号获取对应的video号

# 获取 UGREEN_25854 是哪个 /dev/video*
VIDEODEV=$(
  for dev in /dev/video*; do
    props=$(udevadm info --query=property --name="$dev")
    if echo "$props" | grep -q "ID_MODEL=UGREEN_25854"; then
      echo "$dev"
    fi
  done | head -n 1
)
echo "VIDEODEV=$VIDEODEV"
