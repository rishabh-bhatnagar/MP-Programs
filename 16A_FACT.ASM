; 16 A
; Factorial with recursive procedure


print_str macro x
    mov dx, offset x
    mov ah, 09h
    int 21h
endm

data segment
    FactInput DW 7
data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    mov ax, 01h
    xor bx, bx
    mov bx, FactInput

    CALL p_factorial

    ; ans is in dx, ax
    ; we consider answer to be in ax
    ; < 65536

    CALL hex_to_bcd
    ; convert to bcd and print


exit:
    mov ah, 4ch
    int 21h


proc p_factorial near

    cmp bx, 01h
    jz end_recurse

    mul bx
    dec bx
    CALL p_factorial

    end_recurse:
ret
endp

proc hex_to_bcd near
    ; hex value is in AX

    
    xor cx, cx
    mov bx, 10

    hex1:
        xor dx, dx

        div bx

        ;remainder in dx
        push dx

        ; count of digits
        inc cx

        cmp ax, 00  ;if quotient zero
        je conv_done

        jmp hex1

    conv_done:
        mov ah, 02h

    hex2:
        pop dx
        add dl, 30h
        int 21h

        loop hex2


ret
endp



code ends
end start


print_8bit_num macro x
    mov dl, x
    add dl, 30h
    mov ah, 02h
    int 21h
endm
