ASSUME CS:CODESEG ;关联寄存器

CODESEG SEGMENT   ;定义一个段，段的名称为“CODESEG”，这个段从此开始

	MOV AX,0123H
	MOV BX,0456H
	ADD AX,BX
	ADD AX,AX

	MOV AX,4C00H  ;程序返回
	INT 21H       ;程序返回，XP用20H

CODESEG ENDS      ;名称为“CODESEG”的段到此结束

END               ;汇编程序结束标记