;Deric Mccadden, A00751277
;2018-09-30

%include "asm_io.inc"

%define ARRAY_SIZE 11

segment .data
prompt_head       db    "Enter digit ", 0
prompt_tail       db    ": ", 0
final_message     db    "Full UPC Code: ", 0

segment .bss
digit_array resd ARRAY_SIZE
digit_12 resd 1

segment .text
global  asm_main

asm_main:
        enter   0,0             ; local dword variable at EBP - 4
        pusha

        ;collect digits
        mov     ebx, digit_array
        mov     ecx, 1
        init_loop_start:
            ;print prompt message
            mov     eax, prompt_head
            call    print_string
            ;print digit number
            mov     eax, ecx
            call    print_int
            ;print prompt end
            mov     eax, prompt_tail
            call    print_string
            ;read int
            call    read_int
            mov     [ebx], eax
            ;increment
            add     ebx, 4
            cmp     ecx, ARRAY_SIZE
            je      init_loop_end
            inc     ecx
            jmp     init_loop_start
        init_loop_end:

        ;Step 1 Sum odd digits
        mov     eax, 0
        mov     ebx, digit_array
        mov     ecx, 0
        add_odd_loop_start:
            add     eax, [digit_array+4*ecx]
            ;increment
            add     ebx, 4
            cmp     ecx, ARRAY_SIZE
            jge     add_odd_loop_end
            add     ecx, 2
            jmp     add_odd_loop_start
        add_odd_loop_end:

        ;Step 2 Multiply result by 3
        imul    eax, 3

        ;Step 3 Add even digits
        mov     ebx, digit_array
        mov     ecx, 1
        add_even_loop_start:
            add     eax, [digit_array+4*ecx]
            ;increment
            add     ebx, 4
            cmp     ecx, ARRAY_SIZE
            jge     add_even_loop_end
            add     ecx, 2
            jmp     add_even_loop_start
        add_even_loop_end:

        ;Step 4 Mod by 10
        cdq
        mov    ecx, 10
        idiv   ecx
        mov    eax, edx ;eax==M

        ;Step 5 if(M==0) continue else M=10-M
        cmp    eax, 0 ;eax==M
        je     Yes
        mov    ebx, eax
        mov    eax, 10
        sub    eax, ebx
        Yes:
        mov    [digit_12], eax

        ;print upc message
        mov     eax, final_message
        call    print_string

        ;print digits
        mov     ebx, digit_array
        mov     ecx, 1
        print_loop_start:
            mov     eax, [ebx]
            call    print_int
            ;increment
            add     ebx, 4
            cmp     ecx, ARRAY_SIZE
            je      print_loop_end
            inc     ecx
            jmp     print_loop_start
        print_loop_end:
        mov     eax, [digit_12]
        call    print_int
        call    print_nl


        popa
        mov     eax, 0            ; return back to C
        leave
        ret
