sc delete xlwfp
del %SystemRoot%\System32\Drivers\xlwfp.sys
reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{9FB5F2D4-203E-41D2-932F-6DE145F9756C} /f
reg delete HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{9FB5F2D4-203E-41D2-932F-6DE145F9756C} /f