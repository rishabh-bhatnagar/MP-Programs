data segment
n1 db ?
n2 db ?
msg1 db,10, "Enter number 1 $"
msg2 db,10, "Enter number 2 $"
msg4 db,10, "Product = $"
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

        
        cmp c,03
        jz mult



  mult: mov dx,offset msg4
        mov ah,09
        int 21h

        xor bx,bx
        mov bl,n1
        and bl,0f0h
        rol bl,04
        mov ah,bl

        mov bl,n1
        and bl,0fh
        mov al,bl
        aad
        mov bl,al

        mov cl,n2
        and cl,0f0h
        rol cl,04
        mov ah,cl

        mov cl,n2
        and cl,0fh
        mov al,cl
        aad
        mov cl,al

        xor dx,dx
        mul bl
        aam
        mov cl,al
        mov al,ah
        xor ah,ah
        aam
        mov dl,ah
        mov bl,al

        add dl,30h
        mov ah,02
        int 21h

        mov dl,bl
        add dl,30h
        mov ah,02
        int 21h

        mov dl,cl
        add dl,30h
        mov ah,02
        int 21h
        jmp last

 
last:   mov ah,4ch
        int 21h

code ends
end start
