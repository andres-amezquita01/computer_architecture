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

%macro RANDOM 1
        pusha
        mov ecx, 0xff
        rdtsc
        xor edx, edx
        and eax,ecx
        imul eax, %1
        mov edi, eax
        idiv ecx
        mov [number], eax
        popa
%endmacro

segment .data
; initialized data is put in the data segment here
msg_get_number_to_sum        db      "Enter a limit number:",0
msg_underscore   db "_____________________________",0
msg_menu      db      "Do you want to continue (1 = yes) or (0 = exit)",0
msg_answer      db      "The random number is --> :",0
clear_sh db "clear.sh", 0  ; sh script that executes the clear command"


clr     db 0x1b, "[2J", 0x1b, "[H"
clrlen  equ  $ - clr

segment .bss
; uninitialized data is put in the bss segment

input_1 resd 1                  ;input to get the user's option for the menu
input_2 resd 1                  ;input to get the number to get the random
number  resd 1

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        start:
        CLEAR_SCREEN
        PRINT_STRING msg_get_number_to_sum
        PRINT_STRING msg_underscore

        call read_int
        mov [input_2], eax

        RANDOM [input_2]

        mov eax, [number]

        call print_int
        call print_nl
        mov eax,  msg_menu
        call print_string

        call read_int
        mov [input_1], eax
        cmp eax,0
        je end
        cmp eax,1
        jmp start


        end:
        CLEAR_SCREEN
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


