VBoxManage.exe "C:\Program Files\Oracle\VirtualBox\"
VBoxManage.exe modifyvm "macOS 11 Big Sur" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
VBoxManage.exe setextradata "macOS 11 Big Sur" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac19,1"
VBoxManage.exe setextradata "macOS 11 Big Sur" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
VBoxManage.exe setextradata "macOS 11 Big Sur" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Mac-AA95B1DDAB278B95"
VBoxManage.exe setextradata "macOS 11 Big Sur" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
VBoxManage.exe setextradata "macOS 11 Big Sur" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1