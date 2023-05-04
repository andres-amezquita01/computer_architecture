%include "asm_io.inc" ; Include a library of I/O functions

%macro showing_result 0 ; Define a macro for displaying the result
        pusha
        call print_string
        mov eax,ebx
        call print_int
        call print_nl
        popa
%endmacro


%macro PRINT_STRING 1
pusha
    mov eax, %1
    call print_string
    call print_nl
    popa
%endmacro


%macro inputs 0
        pusha
        mov     eax, prompt1     ; Load the address of the first prompt into eax
        call    print_string    ; Call the I/O function to print the prompt

        call    read_int        ; Call the I/O function to read an integer from standard input
        mov     [input1], eax   ; Store the input in the first double word

        mov     eax, prompt2    ; Load the address of the second prompt into eax
        call    print_string    ; Call the I/O function to print the prompt

        call    read_int        ; Call the I/O function to read another integer from standard input
        mov     [input2], eax   ; Store the input in the second double word

        popa
%endmacro

segment .data ; Declare a data segment for initialized data
;
; These labels refer to strings used for output
;
prompt1 db    "Enter a number: ", 0       ; Declare a string to prompt for input
prompt2 db    "Enter another number: ", 0 ; Declare another string to prompt for input
outmsg1 db    "You entered ", 0           ; Declare a string to output the first input
outmsg2 db    " and ", 0                  ; Declare a string to output a conjunction
outmsg3 db    ", the sum of these is ", 0 ; Declare a string to output the sum
outmsg4 db    ", the sub of these is ", 0 ; Declare a string to output the subtraction
outmsg5 db    ", the multiply of these is ", 0 ; Declare a string to output the multiplication
outmsg6 db    ", the division of these is ", 0 ; Declare a string to output the division
prompt3 db    "0.Salir ", 0
prompt4 db    "1.suma", 0
prompt5 db    "2.resta", 0
prompt6 db    "3.multiplicacion", 0
prompt7 db    "4.division", 0
prompt8 db    "Enter a option: ", 0       ; Declare a string to prompt for input








;
; uninitialized data is put in the .bss segment
;
segment .bss ; Declare a data segment for uninitialized data
;
; These labels refer to double words used to store the inputs
;
input1  resd 1 ; Reserve space for a double word to store the first input
input2  resd 1 ; Reserve space for a double word to store the second input

 

;
; code is put in the .text segment
;
segment .text ; Declare a code segment
        global  asm_main ; Declare the entry point of the program
asm_main: ; Start of the program
        enter   0,0 ; Set up the stack frame 
        pusha ; Save all registers onto the stack


        start:
        PRINT_STRING prompt3
        PRINT_STRING prompt4
        PRINT_STRING prompt5
        PRINT_STRING prompt6
        PRINT_STRING prompt7
        PRINT_STRING prompt8

        call    read_int         
        mov     [input1], eax   



        cmp eax,1
        je adds

        cmp eax,2
        je subs

        cmp eax,3
        je multiply

        cmp eax,4
        je div

        cmp eax,0
        je end
        

        adds:
                inputs
                mov     eax, [input1]   ; Load the first input into eax
                add     eax, [input2]   ; Add the second input to eax
                mov     ebx, eax        ; Move the sum into ebx
                mov     eax, outmsg3    ; Load the address of the sum string into eax
                showing_result          ; Call the macro to display the sum
                jmp start

        subs:
                inputs
                mov     eax, [input1]   ; Load the first input into eax
                sub     eax, [input2]   ; Subtract the second input from eax
                mov     ebx, eax        ; Move the difference into ebx
                mov     eax, outmsg4    ; Load the address of the difference string into eax
                showing_result          ; Call the macro to display the difference
                jmp start

        multiply:
                inputs
                mov     eax, [input1]  ; Move the value of the first input from memory location "input1" into the eax register
                imul    eax, [input2]  ; Multiply the value in the eax register with the value of the second input from memory location "input2" and store the result in eax
                mov     ebx, eax      ; Move the result of the multiplication from eax to ebx
                mov     eax, outmsg5  ; Move the address of the string "outmsg5" into eax
                showing_result       ; Call the macro "showing_result", which prints the string in eax and the value in ebx to the console
                jmp start

        div:
                inputs
                cdq                   ; Sign-extend eax into edx:eax (to set up for division)
                mov     eax, [input1] ; Move the value of the first input from memory location "input1" into the eax register
                xor     edx, edx      ; Zero out the edx register
                mov     ebx, [input2] ; Move the value of the second input from memory location "input2" into the ebx register

                cmp     ebx,0   ; validate if the value is zero
                jg      makediv ; if it different to zero then jump to makediv
                jmp     div     ; else jump to div:
        makediv:
                div     ebx           ; Divide the value in edx:eax by the value in ebx, and store the quotient in eax and the remainder in edx
                mov     ebx, eax      ; Move the quotient from eax to ebx
                mov     eax, outmsg6  ; Move the address of the string "outmsg6" into eax
                showing_result       ; Call the macro "showing_result", which prints the string in eax and the value in ebx to the console
                jmp start

        end:
        popa                  ; Restore the values of the registers saved by the "pusha" instruction
        mov     eax, 0        ; Move 0 into eax (return value for C)
        leave                ; Clean up the stack frame by restoring the previous value of ESP from EBP and popping the current EBP value off the stack
        ret                  ; Return from the function to the calling code in C


