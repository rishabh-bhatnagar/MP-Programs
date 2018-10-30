Print macro x
	mov dx, offset x
	mov ah, 09
	int 21h
endm

get_input macro
	mov ah, 01
	int 21h
	sub al, 30h
	mov bl, al
	int 21h
	sub al, 30h
	rol bl, 04
	add al, bl
endm

data segment
    n1 db ?
    msg1 db, 10, "Enter Hexadecimal Number: $"
    n2 db ?
data ends

code segment
assume cs:code,ds:data
start:  
        mov ax,data
        mov ds,ax

        Print msg1

        get_input
        mov n1, al

        xor ax,ax
        mov al, n1

        aam           ;unpacks the number and stores it in ah and al.

        mov cl, ah    ; store ah into cl.
        rol cl, 04    ; rolled to left by 4 bits, for example 05 becomes 50.

        add cl, al    ; added al and cl and stored in cl.

        
        mov ah,4ch
        int 21h
code ends
end start
