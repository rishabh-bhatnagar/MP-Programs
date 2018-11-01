; 19 A
; Store full name in string
; given first last as separate inputs


print_str macro x
    mov dx, offset x
    mov ah, 09h
    int 21h
endm

data segment
    MsgFirst    DB 10,13,'Enter First Name: $'
    MsgLast     DB 10,13,'Enter Last Name : $'
    MsgFull     DB 10,13,'Full Name: $'
    StrFull     DB 30 DUP('$')


data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax
    mov es, ax

    print_str MsgFirst

    xor cx, cx  ; hold len of StrFull
    lea di, StrFull
    cld ; so di is inc on string operation

    mov ah, 01h

read_str1:
    int 21h

    cmp al, 0dh     ; ascii for enter
    je done_input1

    stosb           ;mov byte from al to [di]

    inc cx
    jmp read_str1


done_input1:

    ; add a space after first name
    mov al, ' '
    stosb
    inc cx

; start reading last name

    print_str MsgLast
    mov ah, 01h

read_str2:
    int 21h

    cmp al, 0dh     ; ascii for enter
    je done_input2

    stosb

    inc cx
    jmp read_str2


done_input2:

    ; start printing the whole string

    lea si, StrFull
    ; cx has total length of string
    cld
    mov ah, 02h

display_full_name:
    lodsb   ;get from [si] to al
    mov dl, al
    int 21h

    loop display_full_name


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

