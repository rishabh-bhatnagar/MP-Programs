print_str macro x
mov ah, 09
mov dx, offset x
int 21h
endm

data segment
    ip_prompt db 10, "Enter a string : "
    np db "Not a palindrome.$"
    p db "A palindrome.$"
data ends

code segment
assume cs:code, ds:data
start : mov ax, data
        mov ds, ax
        mov es, ax
        
        lea di, str1
        mov ah, 01
        
        ;input block
        ip : int 21h
             cmp al, 0dh
             jz endip
             stosb
             inc cx
             jmp ip
        
        endip:
        
        
        lea si, str1
        lea di, str1
        
        dec cx
        add si, cx
        inc cx
        
        nc : cmp cx, 0000    ; next 2 lines I've simulated loop nc
             je palindrome
             dec cx
             
             cmpsb
             jne not_palindrome
             sub si, 2
             jmp nc 
        
        palindrome : print_str  p
                     jmp exit
        
        not_pali: print_str np
        
        exit: mov ah, 4ch
              int 21h
code ends
end start
