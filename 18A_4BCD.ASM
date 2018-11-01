; 18 A
; find sum of digits of 
; 4 digit bcd number from user

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
    MsgEnter    DB 10,13,'Enter 4 digits: $'
    MsgSum      DB 10,13,'Sum : $'
    SumResult   DB 0
data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    print_str MsgEnter
    mov ah, 01h

    mov cx, 04  ; loop 4 times for 4 digits
back:
    int 21h
    sub al, 30h
    add SumResult, al

    loop back

    print_str MsgSum

    ; SumResult will contain hex
    ; convert that to bcd
    mov al, SumResult
    aam

    ; print tens digit
    print_8bit_num AH


    ; print unit digit
    mov al, SumResult
    aam
    print_8bit_num al
    



exit:
    mov ah, 4ch
    int 21h

code ends
end start

