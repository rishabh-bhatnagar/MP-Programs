; 3A
; WAP to add two 16bit BCD and store BCD result in memory

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

data segment
    num1 DW 9899H
    num2 DW 0901H
    ans  DW ?
data ends

code segment
assume cs:code, ds:data
start:
    ; init data segment
    mov ax, data
    mov ds, ax

    xor cx, cx

    ; do addition of 16bit
        
        ; direct 16 bit code which won't handle intermediate hex result
        ;mov ax, num1
        ;add ax, num2
        ;mov ans, ax


        ; add lower byte
        mov al, byte ptr num1
        add al, byte ptr num2

        daa     ;fix hex to bcd

        ; assign lower byte
        mov byte ptr ans, al

        ; add higher byte
        mov al, byte ptr num1 + 1
        adc al, byte ptr num2 + 1
        ; add carry from previous answer

        daa     ;fix hex to bcd
        mov byte ptr ans+1, al

        ; store carry if it exists,
        adc cx, 00

    ; print carry if it is
    cmp cx, 00
    je no_carry

    mov dl, 31h
    mov ah, 02h
    int 21h


no_carry:

    ; print high 8bit of result
    mov bx, ans
    and bx, 0ff00h
    print_8 bh

    ; print lower 8bit of result
    mov bx, ans
    and bx, 00ffh
    print_8 bl


exit:
    mov ah, 4ch
    int 21h
code ends
end start
