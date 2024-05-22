@REM 查看内存是DDR几代

wmic memorychip get Speed,SMBIOSMemoryType,model,manufacturer,partnumber

@REM SMBIOSMemoryType 值 24=DDR3 ，26=DDR4 ，34=DDR5
