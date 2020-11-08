datarea segment
string db 'Hello world!' , 13 , 10 , '$' ; '$' is important!
datarea ends

prognam segment
main proc far
assume cs:prognam,ds:datarea
start:
        push ds
        sub ax,ax ; 清空ax
        push ax

        mov ax,datarea
        mov ds,ax

        lea dx,string
        mov ah,09 ; 调用09中断输出
        int 21h
        ret ; 退出
main endp
prognam ends
end start