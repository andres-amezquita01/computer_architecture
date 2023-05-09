%include "asm_io.inc" ; Include a library of I/O functions
section .data
    fib_msg1 db 'Ingrese un numero: ',0
    fib_msg2 db 'El numero de Fibonacci es: ',0

section .bss
    num resd 1
    fib resd 1

section .text
    global asm_main
    extern printf, scanf

asm_main:
    enter   0,0            
    pusha

    ; Imprimir el mensaje de solicitud de ingreso de número
    mov eax, fib_msg1
    call print_string
    call print_nl

    ; Leer el número ingresado por el usuario
    call    read_int         
    mov     [num],eax
    mov ecx, eax

    mov eax, 0
    mov ebx, 1
    
    ; Calcular el número de Fibonacci
    loop_start:
        cmp  ecx,0
        je done

        add eax, ebx

        mov edx, ebx
        mov ebx, eax
        mov eax, edx

        loop loop_start

    done:
        ; Imprimir el resultado de Fibonacci
        mov eax, fib_msg2
        call print_string
        call print_nl

        mov eax, ebx
        call print_int
        call print_nl


    ; Salida del programa
    popa
    mov     eax, 0            ; return back to C
    leave                     
    ret