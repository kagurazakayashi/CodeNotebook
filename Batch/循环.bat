set a=0
:loop
set /a a+=1
echo. %a%
:::循环50次 这儿写自己的命令
if %a% == 50 goto end
goto loop