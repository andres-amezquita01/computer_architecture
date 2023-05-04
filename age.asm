
%include "asm_io.inc"

LINE_FEED       equ     10

%macro PRINT_STRING 1
pusha
    mov eax, %1
    call print_string
    call print_nl
    popa
%endmacro


%macro read_string 2
        pusha
        mov edi, %1
        mov ecx, %2
%%loopstrstart:
        call read_char
        cmp al, LINE_FEED
        je %%loopstrend
        mov[edi], al
        inc edi
        loop %%loopstrstart
%%loopstrend:
        mov byte [edi], 0
        popa
%endmacro




        segment .data
outmsg1 db "Escribe tu nombre", 0 

outmsg2 db "Escribe tu edad", 0 

outmsg3 db "Eres un nino", 0 

outmsg4 db "Eres un adolescente", 0 

outmsg5 db "Eres un adulto", 0 

outmsg6 db "Eres un viejo", 0 




        segment .bss
age resd 1 
name resb 22


 

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha
        PRINT_STRING outmsg1
        read_string name,20
        
        PRINT_STRING outmsg2
        call    read_int         
        mov     [age],eax

        cmp eax, 12
        jle iskid

        cmp eax, 18
        jle isteen

        cmp eax, 60
        jle isadult

        cmp eax, 60
        jg isold

iskid:
        PRINT_STRING outmsg3
        jmp endprogram

isteen:
        PRINT_STRING outmsg4
        jmp endprogram

isadult:
        PRINT_STRING outmsg5
        jmp endprogram

isold:
        PRINT_STRING outmsg6
        jmp endprogram        



endprogram :
        call print_nl
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


