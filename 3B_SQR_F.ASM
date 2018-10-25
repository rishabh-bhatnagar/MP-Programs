; 3b
; BCD input from user, and display
; the BCD output on
; Write a far procedure to find the
; square of a number. Get the 2-digitscreen.

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
    mov num1, al    ; store tens digit in num1

    ; read digit 2
    mov ah, 01h
    int 21h
    sub al, 30h

    mov ah, num1    ; get tens digit in ah
    aad             ; convert (ah:al)bcd to (al)hex


    call p_square
    ; ans is in ax now

    print_str strAns

    ; convert and print hex in al to bcd
    call p_al_hex_to_bcd

exit:
    mov ah, 4ch
    int 21h

proc p_al_hex_to_bcd near
    
    ; hex value is in al
    xor cx, cx
    xor bx, bx
    mov bl, 10

    hex1:
        mov ah, 00
        ; make ah zero so
        ; (ah:al) / bx works correct

        div bl
        ; quotient in al
        ; remainder in ah

        cmp al, 00
        ; if quotient is zero, conversion is over
        jz conv_done
        xor dx, dx

        mov dl, ah
        ; store al in dl (dh:dl)

        push dx     ; only 16bit push allowed

        inc cx      ; keep track of number of digits

        jmp hex1

    conv_done:
        ; if quotient(al) == 0
        ; one remainder still remains in ah
        mov dl, ah
        ; store al in dl (dh:dl)
        push dx     ; only 16bit push allowed
        inc cx      ; keep track of number of digits

    hex2:
        ; start displaying the number
        mov ah, 02h

        pop dx      ; get digit in dx
        ; dl already has the correct number

        add dl, 30h
        int 21h
        
        loop hex2  ; dec cx, jump to label if cx != 0

    ret
endp p_al_hex_to_bcd

code ends
end start