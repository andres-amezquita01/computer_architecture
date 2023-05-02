
%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
;
; These labels refer to strings used for output
;
prompt1 db    "Enter a number: ", 0       ; don't forget nul terminator
prompt2 db    "Enter another number: ", 0
outmsg1 db    "You entered ", 0
outmsg2 db    " and ", 0
outmsg3 db    ", the sum of these is ", 0
outmsg4 db    ", the sub of these is ", 0
outmsg5 db    ", the multiply of these is ", 0
outmsg6 db    ", the division of these is ", 0

menu_message db "Choose an option",0


;
; uninitialized data is put in the .bss segment
;
segment .bss
;
; These labels refer to double words used to store the inputs
;
input1  resd 1
input2  resd 1

 

;
; code is put in the .text segment
;
segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        mov     eax, prompt1      ; print out prompt
        call    print_string

        call    read_int          ; read integer
        mov     [input1], eax     ; store into input1

        mov     eax, prompt2      ; print out prompt
        call    print_string

        call    read_int          ; read integer
        mov     [input2], eax     ; store into input2

        mov     eax, [input1]     ; eax = dword at input1
        add     eax, [input2]     ; eax += dword at input2
        mov     ebx, eax          ; ebx = eax
;
; next print out result message as series of steps
;
       
        mov     eax, outmsg3
        call    print_string      ; print out third message
        mov     eax, ebx
        call    print_int         ; print out sum (ebx)
        call    print_nl          ; print new-line


        mov     eax, [input1]     ; eax = dword at input1
        sub     eax, [input2]     ; eax += dword at input2
        mov     ebx, eax          ; ebx = eax

        mov     eax, outmsg4
        call    print_string      ; print out third message
        mov     eax, ebx
        call    print_int         ; print out sum (ebx)
        call    print_nl          ; print new-line


        mov     eax, [input1]     ; eax = dword at input1
        imul     eax, [input2]     ; eax += dword at input2
        mov     ebx, eax          ; ebx = eax


        mov     eax, outmsg5
        call    print_string      ; print out third message
        mov     eax, ebx
        call    print_int         ; print out sum (ebx)
        call    print_nl          ; print new-line

cdq
        mov     eax, [input1]     ; eax = dword at input1
        xor edx, edx
        mov     ebx, [input2]     ; eax += dword at input2
        div     ebx          ; ebx = eax
        mov ebx, eax        
    
 
        mov     eax, outmsg6
        call    print_string      ; print out third message
        mov     eax, ebx
        call    print_int         ; print out sum (ebx)
        call    print_nl          ; print new-line


        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

