; 2a
; 8 bit bcd  difference

print_str macro x
    mov dx, offset x
    mov ah, 09h
    int 21h
endm

read_2digit_bcd macro x
    ;read tens digit
    mov ah, 01h
    int 21h
    sub al, 30h
    mov bl, al

    ;read unit digit
    mov ah, 01h
    int 21h
    sub al, 30h

    mov ah, bl
    aad

    mov x, al
endm

print_8bit_num macro x
    mov dl, x
    add dl, 30h
    mov ah, 02h
    int 21h
endm

data segment
    MsgEnter DB 10,13,'Enter BCD 2digit: $'
    MsgAns  DB 10,13,'Ans: $'
    Num1    DB ?
    Num2    DB ?
    Ans     DB ?
    temp    DB ?
data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    print_str MsgEnter
    read_2digit_bcd Num1

    print_str MsgEnter
    read_2digit_bcd Num2

    print_str MsgAns

    mov al, Num1
    sub al, Num2

    JS negative_ans
    ; sub can set sign flag

fix_negative_ans:
    ; if any

    mov Ans, al

    

    ; print tens digit
    mov al, Ans
    aam
    mov temp, ah
    print_8bit_num temp

    ; print unit digit
    mov al, Ans
    aam
    mov temp, al
    print_8bit_num temp


exit:
    mov ah, 4ch
    int 21h

negative_ans:

    ; sign flag was set
    ; so print '-' and get correct ans in AL
    ; original ans in AL, so save that first

    mov temp, al

    mov dl, '-'
    mov ah, 02h
    int 21h

    mov al, 0ffh
    sub al, temp
    ; eg:
    ; 11-23 would give (f4) == (11 + (255-23)+1)
    ; so f4 would be in al(temp)
    ; to get 12 back
    ; we subtract (ff) - (f4)

    inc al
    ; but 255 - 244, wouldn't consider 0
    ; so we need to add one to al


    ; 12 will now be in al
    ; so jump back
jmp fix_negative_ans

code ends
end start


