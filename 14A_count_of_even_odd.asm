data segment
    array db 10 dup(?) 
    bh_odd db 0
    bh_even db 0
    m1 db "Enter 10 elements: $", 0dh
    msg2 db "Even count = $", 0dh
    msg3 db "Odd count = $",0dh
data ends
code segment
    assume cs: code, ds:data
    start: 
        mov ax, data ;initialization 1
        mov ds, ax   ;initialization 2 
        mov dx, offset m1 ;put display msg into display reg
        mov ah, 09 ;09 is used for printing a string
        int 21h 
        lea bx, array ;load base register address
        mov cx, 0ah ;counter
        xor si, si
        mov ah, 01 ;read input
        l1:int 21h               
           sub al, 30h ;convert hex to decimal
           mov bx[si], al ;moving first element into array
           inc si
        loop l1 ;jumps to the location given 
        mov cx, 0ah
        xor si, si
        l4: mov al, bx[si]
            and al, 01  ;and the element with 01, if even result is zero, else odd
            jz l2
            inc bh_odd ;increment odd if not even   
            jmp l3   
            l2: 
                inc bh_even  ;increment even count
            l3: 
                inc si ; increment the index
        loop l4
        mov dx, offset msg2
        mov ah, 09
        int 21h
        ;Display even count
        mov ah, 02
        mov dl, bh_even
        xor dh, dh ;removing the junk value
        add dl, 30h
        int 21h    
        mov dx, offset msg3
        mov ah, 09
        int 21h 
        
        ;Display odd count
        mov ah, 02
        mov dl, bh_odd
        xor dh, dh ;removing the junk value
        add dl, 30h
        int 21h
        mov ah, 4ch  ;terminating the code        
        int 21h                           
code ends
end start
