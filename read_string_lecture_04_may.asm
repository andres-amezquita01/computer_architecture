%include "asm_io.inc" ; Include a library of I/O functions

LINE_FEED       equ     10      ;
                                ;



%macro READ_STRING 2            ;name and lenght
        pusha
        mov edi, %1             ;move to edi the name
        mov ecx, %2             ;move to ecx the name length

%%LOOP_STRING_START:
        call read_char
        cmp al, LINE_FEED
        je %%LOOP_STRING_END
        mov [edi], al
        inc edi
        loop %%LOOP_STRING_START

        %%LOOP_STRING_END
        mov byte [edi],0
        popa
%endmacro



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
name_msg_1 db    "Enter your name: ", 0       ; Declare a string to prompt for input
name_msg_2 db    "Your name is: ", 0       ; Declare a string to prompt for input

age_msg_1 db    "Your age is: ", 0       ; Declare a string to prompt for input
age_msg_2 db    "You are a child!"


teenager_msg_1 db    "Your are a teenager: ", 0       ; Declare a string to prompt for input


                                ; uninitialized data is put in the .bss segment
;
segment .bss ; Declare a data segment for uninitialized data
;
; These labels refer to double words used to store the inputs
;

name    resd 1                  ;
age    resd 1                  ;

;
; code is put in the .text segment
;
segment .text ; Declare a code segment
        global  asm_main ; Declare the entry point of the program
asm_main: ; Start of the program
        enter   0,0 ; Set up the stack frame 
        pusha ; Save all registers onto the stack
        start:

        read_user_name:
                PRINT_STRING name_msg_1
                READ_STRING name , 20
                PRINT_STRING name_msg_2
                PRINT_STRING name

        read_age:
                call read_int
                mov [age], eax
                PRINT_STRING age_msg_1
        iskid:
                cmp eax,12
                jle you_are_child
                jump teenager

        you_are_child:
                PRINT_STRING age_msg_2

        teenager:
                PRINT_STRING teenager_msg_1




        popa                  ; Restore the values of the registers saved by the "pusha" instruction
        mov     eax, 0        ; Move 0 into eax (return value for C)
        leave                ; Clean up the stack frame by restoring the previous value of ESP from EBP and popping the current EBP value off the stack
        ret                  ; Return from the function to the calling code in C


