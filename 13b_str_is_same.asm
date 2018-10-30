get_str macro x
	mov ah, 0ah
	lea dx, x
	int 21h
endm

Print macro x
	mov ah,09
	lea dx,x
	int 21h
endm

data segment

        str1 db 80 dup('$')
        str2 db 80 dup('$')
        msg1 db 10, 'ENTER THE FIRST STRING :$'
        msg2 db 10, 'ENTER THE SECOND STRING :$'
        msg3 db 10, 'THE TWO STRINGS ARE EQUAL$'
        msg4 db 10, 'THE TWO STRINGS ARE NOT EQUAL$'
data ends


code segment
assume cs:code,ds:data
start:

         mov ax, data
         mov es, ax
         mov ds, ax

         Print msg1
         get_str str1

         Print msg2
         get_str str2
       
         lea si, str1 + 2
         lea si, str2 + 2
       
         mov cl, str1 + 1      ; for storing the length of the string
         mov ch, 00h

         repe cmpsb
         jne notequal

         Print msg3
         jmp last

     notequal:
         Print msg4

     last:      
         mov ax,4ch
         int 21h
        
code ends
end start