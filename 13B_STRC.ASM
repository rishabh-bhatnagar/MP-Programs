; 13 B
; Compare two given strings
; print "same" or "different"

print_str macro x
    mov dx, offset x
    mov ah, 09h
    int 21h
endm

data segment
    Str1    DB 'HELLO','$'
    LenStr1 DB 5
    Str2    DB 'HEFLO','$'
    LenStr2 DB 5

    MsgSame     DB 10,13,'Same','$'
    MsgDiff     DB 10,13,'Different','$'
data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax
    mov es, ax

    ;compare lengths of both strings
    mov al, LenStr1
    cmp al, LenStr2

    ; if lenths is not same
    JNE ans_different

start_comparing:
    
    xor cx, cx
    mov cl, LenStr1
    lea si, Str1
    lea di, Str2
    cld
    repe cmpsb

    jnz ans_different

    jmp ans_same


exit:
    mov ah, 4ch
    int 21h

ans_same:
    print_str MsgSame
jmp exit

ans_different:
    print_str MsgDiff
jmp exit

code ends
end start
