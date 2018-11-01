; 4a
; 16 bit subtraction

print_8 macro x
    
    ; get higher digit into dl
    mov al, x
    and al, 0f0h
    rol al, 04
    mov dl, al
    add dl, 30h  ; convert to ascii

    mov ah, 02h
    int 21h      ; print left digit

    ; get lower digit into dl
    mov al, x
    and al, 0fh
    mov dl, al
    add dl, 30h

    mov ah, 02h
    int 21h     ; print right digit
endm

print_str macro x
    mov dx, offset x
    mov ah, 09h
    int 21h
endm

data segment
    Num1 DW 9221H
    Num2 DW 8323H
    Ans  DW ?
    temp DB ?
data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    ;sub lower byte
        mov al, byte ptr Num1
        sub al, byte ptr Num2
        das
        mov byte ptr Ans, al

    ;sub higher byte
        mov al, byte ptr Num1+1
        sbb al, byte ptr Num2+1
        ;sub with borrow
        das
        mov byte ptr Ans+1, al

    
    ;print higher byte
    mov bx, Ans
    and bx, 0ff00h
    mov temp, bh
    print_8 temp

    ;print lower byte
    mov bx, Ans
    and bx, 00ffh
    mov temp, bl
    print_8 temp



exit:
    mov ah, 4ch
    int 21h

code ends
end start


print_8bit_num macro x
    mov dl, x
    add dl, 30h
    mov ah, 02h
    int 21h
endm

