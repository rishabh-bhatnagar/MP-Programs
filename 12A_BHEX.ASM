; 12 A
; read 2 digit bcd, convert to hex
; store in a mem location

print_str macro x
    mov dx, offset x
    mov ah, 09h
    int 21h
endm

data segment
    MsgEnter    DB 10,13,'Enter 2 digit bcd:','$'
    Num2digit DB ?
data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    print_str MsgEnter
    
    mov ah, 01h
    int 21h
    sub al, 30h
    mov bl, al

    mov ah, 01h
    int 21h
    sub al, 30h

    mov ah, bl
    aad

    mov Num2digit, al

exit:
    mov ah, 4ch
    int 21h

code ends
end start

