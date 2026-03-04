# bat循环
SET a=0
:loop
SET /A a+=1
ECHO. %a%
:::循环50次 这儿写自己的命令
IF %a% == 50 GOTO end
GOTO loop