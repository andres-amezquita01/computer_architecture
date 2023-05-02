%include "asm_io.inc"

%macro PRINT_STRING 1
pusha
    mov eax, %1
    call print_string
    popa
%endmacro

%macro PRINT_INT 1
    pusha
    mov eax, %1
    call print_int
    popa
%endmacro

%macro PRINT_NL 0
    pusha
    call print_nl
    popa
%endmacro


segment .data ; Output strings
        prompt db "Enter a number: ", 0
        square_msg db "Square of input is ", 0
        cube_msg db "Cube of input is ", 0
        cube25_msg db "Cube of input times 25 is ", 0
        quot_msg db "Quotient of cube/100 is ", 0
        rem_msg db "Remainder of cube/100 is ", 0
        neg_msg db "The negation of the remainder is ", 0

segment .bss
    input resd 1

segment .text
    global asm_main



asm_main:
    enter 0,0 ; setup routine
    pusha

    PRINT_STRING prompt
    call read_int
    mov [input], eax

    imul eax ; edx:eax = eax * eax
    mov ebx, eax ; save answer in ebx

    PRINT_STRING square_msg
    PRINT_INT ebx
    PRINT_NL

    imul ebx,[input]; ebx*=[input]
    PRINT_STRING cube_msg
    PRINT_INT ebx
    PRINT_NL

    imul ecx, ebx, 25 ; ecx = ebx*25
    PRINT_STRING cube25_msg
    PRINT_INT ecx
    PRINT_NL

    mov eax, ebx
    cdq ; initialize edx by sign extension
    mov ecx, 100 ; can’t divide by immediate value
    idiv ecx ; edx:eax / ecx

    mov ecx, eax ; save quotient into ecx
    PRINT_STRING quot_msg
    PRINT_INT ecx
    PRINT_NL

    PRINT_STRING rem_msg
    PRINT_INT edx
    PRINT_NL

    neg edx ; negate the remainder
    PRINT_STRING neg_msg
    PRINT_INT edx
    PRINT_NL

    popa
    mov eax, 0 ; return back to C
    leave
    ret

