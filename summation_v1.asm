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
msg_menu        db      "Select a option:",0
msg_menu_opt_1        db      "0) Exit",0
msg_menu_opt_2        db      "1) Sum",0
msg_get_number_to_sum        db      "Entry the number you want to get the summation:",0
msg_answer      db      "The sum is:",0

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
        PRINT_STRING msg_menu
        PRINT_STRING msg_menu_opt_1
        PRINT_STRING msg_menu_opt_2

        call read_int
        mov [input_1], eax

        cmp eax, 0
        je end

        cmp eax, 1
        je summation

        summation:
                PRINT_STRING msg_get_number_to_sum

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
                jmp start

        end:
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


