; 24 A
; Display N numbers in ascending numbers

print_str macro x
    mov dx, offset x
    mov ah, 09h
    int 21h
endm

print_comma_space macro
    mov dl, ','
    mov ah, 02h
    int 21h
    mov dl, ' '
    mov ah, 02h
    int 21h
endm

print_8b_bcd macro x
    mov dl, x
    add dl, 30h
    mov ah, 02h
    int 21h
endm

data segment
    NoOfAsc DB 30
    promptAscNums DB 10,13, 'Asc Numbers: ',10,13,'$'
    iter_var DB 0
    temp DB ?
    word_temp DW ?
data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    print_str promptAscNums

    xor cx, cx
    mov cl, NoOfAsc


back:
    mov al, iter_var

    aam     ; convert (al)hex to (ah:al)bcd
    mov word_temp, ax
    ; store result in var, since ax gets changed on other operations

    mov ax, word_temp   ;mov to ax, since we need to retrieve ah
    mov temp, ah
    print_8b_bcd temp

    mov ax, word_temp   ;mov to ax, since we need to retrieve al
    mov temp, al
    print_8b_bcd temp
    ; need to pass memory location to macro,
    ; since passing register to macro is a bad idea
    

    print_comma_space
    inc iter_var

    loop back 
    ; loop will run for cx iterations ie NoOfAsc iterations



exit:
    mov ah, 4ch
    int 21h
code ends
end start