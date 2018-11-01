print_str macro x
mov ah, 09
mov dx, offset x
int 21h
endm

data segment
    ip_prompt db 10, "Enter a string : "
    str1 db 10 dup('$')
    str2 db "rishabh"
    ess db "equal$"
    ness db "not equal$"
    
data ends

code segment
assume cs:code, ds:data
start : mov ax, data
        mov ds, ax
        mov es, ax
        
        print_str ip_prompt
        
        lea si, str1
        mov ah, 01
        
        xor cx, cx
        
        ip : int 21h
             
             cmp al, 13
             jz endip
             
             mov [si], al
             inc si
             inc cx
             
             jmp ip
        
        endip:
        lea si, str1
        lea di, str2
        
        add si, cx
        
        l1 : std
             loadsb
             
             dec di
             loop l1
        exit:
        
        print_str str1
        print_str str2
        
        mov ah, 4ch
        int 21h
code ends
end start
