; file: skel.asm
; This file is a skeleton that can be used to start assembly programs.

%include "asm_io.inc"

;***MACROS***

%macro PRINT_STRING 1
        pusha
        mov eax, %1
        call print_string
        call print_nl
        popa
%endmacro


segment .data
; initialized data is put in the data segment here
msg_title       db "Multiplication table", 0
msg_underscore   db "_____________________________",0
msg_get_number_to_sum        db      "Enter a number:",0
msg_menu      db      "Do you want to continue (1 = yes) or (0 = exit)",0
msg_answer      db      "The result is:",0

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
        PRINT_STRING msg_title
        PRINT_STRING msg_underscore

        jmp multiply


        multiply:
                mov eax,  msg_get_number_to_sum
                call print_string

                call read_int
                mov [input_2], eax

                mov eax, [input_2]
                mov ecx, [input_2]
                loop_start:
                        add eax, ecx
                loop loop_start
                PRINT_STRING msg_answer
                sub eax, [input_2]
                call print_nl
                call print_int
                call print_nl
                jmp menu
        menu:
                PRINT_STRING msg_menu
                call read_int
                mov [input_1], eax
                cmp eax, 0
                je end

                cmp eax, 1
                je start


        end:
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


