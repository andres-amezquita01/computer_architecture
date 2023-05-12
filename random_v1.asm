; file: skel.asm
; This file is a skeleton that can be used to start assembly programs.

%include "asm_io.inc"

;***MACROS***

%macro CLEAR_SCREEN 0
        pusha
        mov eax,4
        mov ebx, 1
        mov ecx, clr
        mov edx, clrlen
        int 0x80
        popa
%endmacro

%macro PRINT_STRING 1
        pusha
        mov eax, %1
        call print_string
        call print_nl
        popa
%endmacro

%macro PRINT_MULTIPLY 1
        pusha
        mov eax, %1
        call print_string
        popa
%endmacro

segment .data
; initialized data is put in the data segment here
msg_title       db "Multiplication table", 0
msg_underscore   db "_____________________________",0
msg_get_number_to_sum        db      "Enter a number:",0
msg_menu      db      "Do you want to continue (1 = yes) or (0 = exit) (2 = time)",0
msg_answer      db      "The result is --> :",0
msg_multiply_sign      db      " x ",0
msg_equal_sign      db      " = ",0
clear_sh db "clear.sh", 0  ; sh script that executes the clear command"


clr     db 0x1b, "[2J", 0x1b, "[H"
clrlen  equ  $ - clr

segment .bss
; uninitialized data is put in the bss segment

input_1 resd 1                  ;input to get the user's option for the menu
input_2 resd 1                  ;input to get the number to sum
 

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        start:
        CLEAR_SCREEN
        PRINT_STRING msg_title
        PRINT_STRING msg_underscore

        mov eax,  msg_get_number_to_sum
        call print_string

        call read_int
        mov [input_2], eax
        cmp input_2,0
        cmp in
        jmp multiply
                                ;
multiply:
        mov eax,  msg_get_number_to_sum
        call print_string

        call read_int
        mov [input_2], eax

        mov ecx,0
loop_start:
        mov eax, [input_2]
        imul eax, ecx


        PRINT_MULTIPLY msg_answer
        mov ebx,eax
        mov eax,[input_2]
        call print_int
        PRINT_MULTIPLY msg_multiply_sign
        mov eax, ecx
        call print_int
        PRINT_MULTIPLY msg_equal_sign
        mov eax, ebx
        call print_int


        call print_nl

        cmp ecx,10
        je menu
        inc ecx
        jmp loop_start
        loope loop_start
menu:
        PRINT_STRING msg_menu
        call read_int
        mov [input_1], eax
        cmp eax, 0
        je end

        cmp eax, 1
        je start
printTime:

        push bp
        mov bp , sp
        push ax
        push bx
        push cx
        push dx
        push si
        push di
        push es

        call clearScreen

        mov si , 0  ;counter to use 3 prints i.e. Hrs, Min, Sec
        mov ax , 0xB800
        mov es , ax
        mov di , 142

end:
        CLEAR_SCREEN
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


