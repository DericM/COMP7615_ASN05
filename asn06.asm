;Deric Mccadden, A00751277
;2018-09-30

%include "asm_io.inc"

section .data
    result dw 0;

section .text
    global  mult_asm

mult_asm:
    enter 0,0 
    pusha

    mov eax, [ebp + 8]
    imul eax, [ebp + 12]
    mov [result], eax
    call print_int
    call print_nl

    popa
    mov eax, [result]           ; return back to C
    leave
    ret
