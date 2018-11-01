; 15A
; find max, min of array of user given elements

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
    MsgEnter DB 10,13,'Enter 10 nums',10,13,'$'
    MsgMax   DB 10,13,'Max: $'
    MsgMin   DB 10,13,'Min: $'
    Array   DB 20 DUP(0)
    MaxNum     DB 0
    MinNum     DB 9

data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    print_str MsgEnter

    mov cx, 10
    mov ah, 01h
    lea bx, Array
    xor si, si

    input1:
        int 21h
        sub al, 30h
        mov [bx+si], al
        inc si
        loop input1

    ;; array read

    mov cx, 10
    lea bx, Array
    xor si, si

    iterate:
        mov al, bx[si]

        cmp al, MaxNum
        jg max_assign

        max_assign_done:

        cmp al, MinNum
        jl min_assign

        min_assign_done:

        inc si
        loop iterate

    display_answer:
        print_str MsgMax
        print_8bit_num MaxNum

        print_str MsgMin
        print_8bit_num MinNum

exit:
    mov ah, 4ch
    int 21h


max_assign:
    mov MaxNum, al
    jmp max_assign_done

min_assign:
    mov MinNum, al
    jmp min_assign_done


code ends
end start



