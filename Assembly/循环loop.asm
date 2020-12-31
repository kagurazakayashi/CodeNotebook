ASSUME CS:CODESEG
CODESEG SEGMENT
	; 编程计算 2^2，结果存在 ax 中
	; 设  (ax)=2，可计算 (ax)=(ax)*2，最后 (ax) 中为 2^2 的值。 N*2 可用 N+N 实现。
	MOV AX,2
	ADD AX,AX
	; 编程计算 2^3
	; 2^3=2*2*2，若设 (ax)=2，可计算 (ax)=(ax)*2*2，最后 (ax) 中为 2^3 的值。 N*2 可用 N+N 实现。
	MOV AX,2
	ADD AX,AX
	ADD AX,AX
	; 编程计算 2^12，需要 11 条重复的指令 add ax,ax 。可用 loop 来简化程序。
	MOV AX,2
	MOV CX,11
s0: ADD AX,AX  ; 标号 s 代表一个地址
	LOOP s0  ; CPU 执行 (cx)=(cx)-1 然后判断不为0则执行标号 s，如果是0则继续下一行
	; 用加法计算 123*236，结果存在 ax 中。
	; 可用循环将 123 加 236 次。可先设 (ax)=0 ，然后循环做 236 次 (ax)=(ax)+123
	MOV AX,0
	MOV CX,236
s1: ADD AX,123
	LOOP s1
    ; 做了 236 次加法。也可以将 236 加 123 次。可先设 (ax)=0 ，然后循环做 123次 (ax)=(ax)+236。
    MOV AX,0FFFFH
    MOV DS,AX
    MOV BX,6  ; 以上，设置 ds:bx 指向 ffff:6
    MOV AL,[BX]
    MOV AH,0  ; 以上，设置 (al)=((ds*16)+(bx)), (ah)=0
    MOV DX,0  ; 累加寄存器清 0
    MOV CX,3  ; 循环 3 次
s3: ADD DX,AX
    LOOP s3   ; 以上累加计算 (ax)*3
	; 结束返回
	MOV AX,4C00H
	INT 21H
CODESEG ENDS
END