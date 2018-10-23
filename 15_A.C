;Find minimum and maximum element of an array.

print macro x
mov dx,offset x
mov ah,09
int 21h
endm

data segment
array1 db 10 dup(?)
mn db ?
mx db ?
msg1 db 10,"Minimum:$"
msg2 db 10,"Maximum:$"
data ends

code segment
assume cs: code,ds:data
start: mov ax, data
       mov ds, ax

       mov cx, 08
       lea bx, array1
       mov ah, 01h
       xor si, si

       ln : int 21h
            sub al, '0'
            mov bx[si], al
            inc si
            loop ln

       lea bx, array1
       xor si, si
       mov cx, 08
       mov ah, 00
       mov al, 09
    l4:cmp bx[si],ah
       jg l1
       cmp bx[si],al
       jb l2
       jmp l3
    l1:mov ah,bx[si]
       jmp l3
    l2:mov al,bx[si]
    l3:inc si
       loop l4

    mov mn,al
    mov mx,ah

    print msg1
    xor dx,dx
    mov dl,mn
    add dl,30h
    mov ah,02
    int 21h

    print msg2
    xor dx,dx
    mov dl,mx
    add dl,30h
    mov ah,02
    int 21h

mov ah,4ch
int 21h

code ends
end start
