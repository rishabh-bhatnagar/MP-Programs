; 3b
; Write a far procedure to find the
; square of a number. Get the 2-digit
; BCD input from user, and display
; the BCD output on screen.

print_str macro x
    mov dx, offset x
    mov ah, 09h
    int 21h
endm


bongo segment
proc p_square far
    mul al
    ret
endp p_square
bongo ends


data segment
    strEnter DB 10,13, 'Enter 2 digit number:', '$'
    strAns   DB 10,13, 'Square is:', '$'
    num1     DB ?
    ans      DW ?
data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    print_str strEnter

    ; read digit 1
    mov ah, 01h
    int 21h
    sub al, 30h
    mov num1, al
    rol num1, 04    ; move to tens place

    ; read digit 2
    mov ah, 01h
    int 21h
    sub al, 30h
    add num1, al

    mov al, num1
    call p_square
    ; ans is in ax now

    print_str strAns

    ; convert hex in ax to bcd
    call p_hex_to_bcd

exit:
    mov ah, 4ch
    int 21h

proc p_hex_to_bcd near
    
    ; hex is in ax register
    xor bx, bx
    mov bx, 10
    xor cx, cx

    hex1:
        xor dx, dx
        div bx
        push dx
        inc cx
        cmp ax, 00
        jg hex1

    mov ah,02h
    hex2:
        pop dx
        add dx, '0'
        int 21h
        loop hex2

    ret
endp p_hex_to_bcd

code ends
end start