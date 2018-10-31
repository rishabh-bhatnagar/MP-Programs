data segment
n1 db ?
n2 db ?
msg1 db,10, "Enter number 1 $"
msg2 db,10, "Enter number 2 $"
msg7 db,10, "Sum = $ "
c db ?
data ends

code segment
assume cs:code,ds:data
start:
        mov ax,data
        mov ds,ax

        mov dx,offset msg1
        mov ah,09
        int 21h

        mov ah,01
        int 21h
        sub al,30h
        mov bl,al
        int 21h
        sub al,30h
        rol bl,04
        add al,bl
        mov n1,al

        mov dx,offset msg2
        mov ah,09
        int 21h

        mov ah,01
        int 21h
        sub al,30h
        mov bl,al
        int 21h
        sub al,30h
        rol bl,04
        add al,bl
        mov n2,al

        cmp c,01
        jz ad


    ad: mov dx,offset msg7
        mov ah,09
        int 21h

        xor ax,ax
        mov al,n1
        add al,n2
        daa
        mov bx,ax

        mov cl,bl
        rol cl,04
        and cl,0fh
        add cl,30h

        mov dx,cx
        mov ah,02
        int 21h

        and bl,0fh
        add bl,30h
        mov dx,bx
        mov ah,02
        int 21h
        jmp last


last:   mov ah,4ch
        int 21h

code ends
end start
