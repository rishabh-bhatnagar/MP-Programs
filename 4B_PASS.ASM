; 4b
; check password

print_str macro x
    mov dx, offset x
    mov ah, 09h
    int 21h
endm

data segment
    MsgEnter    DB 10,13,'Enter password:$'
    OG_Pass     DB 'pass'
    User_Pass   DB 4 DUP(0)
    LEN_PASS    EQU 4

    MsgRight    DB 10,13,'Right password$'
    MsgWrong    DB 10,13,'Wrong password$'
data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax
    mov es, ax

    print_str MsgEnter

    xor cx, cx
    lea di, User_Pass
    cld

    mov ah, 08h
    ; using 08 so no echo happens to console

input1:
    int 21h
    cmp al, 0dh ; compare with enter key
    je input_done

    stosb
    inc cx

    jmp input1

input_done:

    cmp cx, LEN_PASS
    jne wrong_pass

    ; start comparison
    lea si, OG_Pass
    lea di, User_Pass
    cld

    repe cmpsb
    jnz wrong_pass

    right_pass:
        print_str  MsgRight

exit:
    mov ah, 4ch
    int 21h

wrong_pass:
    print_str MsgWrong
jmp exit

code ends
end start


print_8bit_num macro x
    mov dl, x
    add dl, 30h
    mov ah, 02h
    int 21h
endm
