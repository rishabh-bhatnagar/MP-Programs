; 14a
; User array of 10 elements
; count even odd parity

print_str macro x
    mov dx, offset x
    mov ah, 09h
    int 21h
endm

print_8bit_num macro x
    mov dl, x
    add dl, 30h
    mov ah, 02h
    int 21h
endm

data segment
    MsgEnter    DB 10,13,'Enter Array:',10,13,'$'
    MsgEven     DB 10,13,'Even Parity: $'
    MsgOdd      DB 10,13,'Odd Parity : $'
    CountEven   DB 0
    CountOdd    DB 0
    Array       DB 20 DUP(0)
    LEN_ARRAY   EQU 10  ; works like #define
data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    print_str MsgEnter

    lea bx, Array
    xor si, si
    xor cx, cx
    mov cx, LEN_ARRAY
    mov ah, 01h

    input1:
        int 21h
        sub al, 30h
        mov bx[si], al

        inc si
        loop input1

    input_done:

        lea bx, Array
        xor si, si
        mov cx, LEN_ARRAY

    calculate_parity:
        mov al, bx[si]

        and al, 0ffh    ;parity flag will set

        jp Even_Parity_Assign

        jmp Odd_Parity_Assign

        Parity_Assign_Done:

        inc si
        loop calculate_parity

    display_answer:

        print_str MsgEven
        print_8bit_num CountEven

        print_str MsgOdd
        print_8bit_num CountOdd

exit:
    mov ah, 4ch
    int 21h

Even_Parity_Assign:
    inc CountEven
    jmp Parity_Assign_Done

Odd_Parity_Assign:
    inc CountOdd
    jmp Parity_Assign_Done

code ends
end start

