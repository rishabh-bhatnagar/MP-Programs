data segment
	msg db 10, "Enter the number$"
	n db ?
	array db 100 dup(?)
data ends

code segment
	assume cs : code , ds:data
	start:  mov ax,data
			mov ds,ax

			mov dx,offset msg
			mov ah,09
			int 21h

			mov ah,01
			int 21h
			sub al,30h
			mov bl,al
			int 21h
			sub al,30h
			mov ah,bl
			aad

			mov n,al
			mov cl,n
			lea bx,array
			xor si,si

			l1 :mov bx[si],cl
				inc si
			loop l1

			mov cx,si
			xor si,si

			l2: xor ah,ah
				mov al,bx[si]
				inc si
				aam
				add ax,3030h
				mov ch,al
				mov dl,ah
				mov ah,02
				int 21h
				mov dl,ch
				int 21h
				xor ch,ch
				mov dx,20h ;space
				mov ah,02
				int 21h
			loop l2
	mov ah,4ch
	int 21h
code ends
end start