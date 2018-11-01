; 17 A
; given 8 bit hex num in memory location
; convert and display the bcd

print_str macro x
    mov dx, offset x
    mov ah, 09h
    int 21h
endm

data segment
    p_param_hex DB 0ffh
data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    CALL p_hex_to_bcd
    ; param is in p_param_hex

exit:
    mov ah, 4ch
    int 21h

proc p_hex_to_bcd

    ; hex is in p_param_hex

    xor ax, ax
    mov al, p_param_hex 
    ; since p_param_hex is DB

    xor cx, cx ;keep count of no of digits
    mov bx, 10

hex1:
    xor dx, dx
    div bx

    ; remainder in dx
    push dx
    inc cx

    ; if quotient is zero, quit 
    cmp ax, 00
    jz conv_done

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
