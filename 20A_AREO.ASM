; 20 A
; take user given array of 10 elements
; count even and odd

print_str macro x
    mov dx, offset x
    mov ah, 09h
    int 21h
endm

data segment
    CountEven   DB 0
    CountOdd    DB 0
    MsgEnter    DB 10,13,'Enter 10 elements:',10,13,'$'
    Array       DB 10 DUP(?)

    MsgEven     DB 10,13,'Even: ','$'
    MsgOdd      Db 10,13,'Odd : ','$'
data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    print_str MsgEnter

    xor si, si
    lea bx, Array
    mov cx, 10
    mov ah, 01

read:
    int 21h
    sub al, 30h
    mov [bx+si], al
    inc si

    loop read

; array reading done

; start counting even odd

    xor si, si
    lea bx, Array
    mov cx, 10

even_odd:
    
    mov al, [bx+si]
    and al, 01h ; retrive right most bit

    JZ even_num ; and sets the zero bit depending on result

    odd_num:
        inc CountOdd
        jmp check_done

    even_num:
        inc CountEven
        jmp check_done

    
check_done:
    
    inc si
    loop even_odd

; finally display the count


    print_str MsgOdd
    mov dl, CountOdd
    add dl, 30h
    mov ah, 02h
    int 21h

    print_str MsgEven
    mov dl, CountEven
    add dl, 30h
    mov ah, 02h
    int 21h


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
