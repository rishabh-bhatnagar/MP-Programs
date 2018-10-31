;AIM : find lcm of two numbers using procedures.

; Logic :

; 1.       a = int(input("8 bit number"))
; 2.       b = int(input("8 bit number"))
; 3.       lcm_a = a
; 4.       lcm_b = b
; 5.       if lcm_a > lcm_b:
; 6            lcm_b += b
; 7               goto 5.
; 8.       elif lcm_a == lcm_b:
; 9.           print("LCM", lcm_a)
; 10.      else:
; 11.          lcm_a += a
; 12.          goto 5.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;scr : https://stackoverflow.com/questions/15832893/printing-a-new-line-in-assembly-language-with-ms-dos-int-21h-system-calls
println macro
MOV dl, 10
MOV ah, 02h
INT 21h
MOV dl, 13
MOV ah, 02h
INT 21h
endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

hex_to_bcd_8b macro x
; assume x has 38                  // 0x38 = 56
xor ah, ah;         ax <-- 00 xx
mov al, x;          ax <-- 00 38     // 38 is hex equivaent of 56.
aam;                ax <-- 05 06
ror ah, 04;         ax <-- 50 06
add al, ah;         ax <-- 50 56
mov x, al;           x <-- 56

endm;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

print_msg macro x
mov dx, offset x
mov ah, 09
int 21h
endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

bcd_to_hex_8b macro x
; assume x has 56  ; 56 = 0x38

; what aad does is consider ah as higher bit and
; al as lower bit of bcd number
; and stores hex of ah, al in al
; So, for us, 03 should be in ah and al should have 08.

mov ah, x  ;        ax <-- 38 xx
mov al, x  ;        ax <-- 38 38
ror ah, 04 ;        ax <-- 83 38
and ah, 0fh;        ax <-- 03 38
and al, 0fh;        ax <-- 03 08
aad
mov x, al
endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

input_8b macro x
;assuming  user wants to enter 56, 
mov ah, 01;      ax <-- 01 xx
int 21h;         ax <-- 01 35
sub al, '0';     ax <-- 01 05
ror al, 04;      ax <-- 01 50
mov bh, al;      bl <-- 50
int 21h;         ax <-- 01 36
sub al, '0';     ax <-- 01 06
add al, bh;      ax <-- 01 56
mov x, al
endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

print_4b macro x
mov ah, 02
mov dl, x
add dl, '0'
int 21h
endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

print_8b macro x
; assuming x <-- 56

; printing higher digit : 
mov dl, x        ; dl <-- 56
ror dl, 04       ; dl <-- 65
and dl, 0fh      ; dl <-- 05
print_4b dl

;printing lower digit
mov dl, x
and dl, 0fh
print_4b dl

endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;#############################################################################
data segment
    a db ?
    b db ?
    lcm_a dw ?
    lcm_b dw ?
    ip_prompt_1 db "Enter first number : $"
    ip_prompt_2 db "Enter second number : $"
    lcm_is db "Lcm of entered numbers is : $"
data ends
;#############################################################################
code segment
assume cs:code, ds:data

start : mov ax, data
        mov ds, ax

        xor ax, ax
        xor bx, bx

        print_msg ip_prompt_1
        input_8b a          ; 1
        println

        print_msg ip_prompt_2
        input_8b b          ; 2
        println

        ; converting both a and b to hex.
        bcd_to_hex_8b a
        bcd_to_hex_8b b


        xor ah, ah          ; 3
        mov al, a
        mov lcm_a, ax       ; 3

        mov al, b           ; 4
        mov lcm_b, ax       ; 4

loopback : mov ax, lcm_a       ; 5
        cmp ax, lcm_b

        jg lcm_a_greater    
        jz lcm_found        ; 7

lcm_b_greater:
mov ax, lcm_a               ; 11
    mov bl, a
    xor bh, bh
    add ax, bx
    mov lcm_a, ax           ; 11
    jmp loopback            ; 12

lcm_a_greater:
    mov ax, lcm_b           ; 6
    mov bl, b
    xor bh, bh
    add ax, bx
    mov lcm_b, ax           ; 6
    jmp loopback

lcm_found :
    mov cx, lcm_a

    hex_to_bcd_8b ch         ; this logic might fail for 16 bits answer
    hex_to_bcd_8b cl         ; replace these two line with conversion from 16bit hex to bcd
    
    print_msg lcm_is
    print_8b ch
    print_8b cl

terminate: mov ah, 4ch
           int 21h
code ends
end start
;#############################################################################;AIM : find lcm of two numbers using procedures.

; Logic :

; 1.       a = int(input("8 bit number"))
; 2.       b = int(input("8 bit number"))
; 3.       lcm_a = a
; 4.       lcm_b = b
; 5.       if lcm_a > lcm_b:
; 6            lcm_b += b
; 7               goto 5.
; 8.       elif lcm_a == lcm_b:
; 9.           print("LCM", lcm_a)
; 10.      else:
; 11.          lcm_a += a
; 12.          goto 5.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;scr : https://stackoverflow.com/questions/15832893/printing-a-new-line-in-assembly-language-with-ms-dos-int-21h-system-calls
println macro
MOV dl, 10
MOV ah, 02h
INT 21h
MOV dl, 13
MOV ah, 02h
INT 21h
endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

hex_to_bcd_8b macro x
; assume x has 38                  // 0x38 = 56
xor ah, ah;         ax <-- 00 xx
mov al, x;          ax <-- 00 38     // 38 is hex equivaent of 56.
aam;                ax <-- 05 06
ror ah, 04;         ax <-- 50 06
add al, ah;         ax <-- 50 56
mov x, al;           x <-- 56

endm;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

print_msg macro x
mov dx, offset x
mov ah, 09
int 21h
endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

bcd_to_hex_8b macro x
; assume x has 56  ; 56 = 0x38

; what aad does is consider ah as higher bit and
; al as lower bit of bcd number
; and stores hex of ah, al in al
; So, for us, 03 should be in ah and al should have 08.

mov ah, x  ;        ax <-- 38 xx
mov al, x  ;        ax <-- 38 38
ror ah, 04 ;        ax <-- 83 38
and ah, 0fh;        ax <-- 03 38
and al, 0fh;        ax <-- 03 08
aad
mov x, al
endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

input_8b macro x
;assuming  user wants to enter 56, 
mov ah, 01;      ax <-- 01 xx
int 21h;         ax <-- 01 35
sub al, '0';     ax <-- 01 05
ror al, 04;      ax <-- 01 50
mov bh, al;      bl <-- 50
int 21h;         ax <-- 01 36
sub al, '0';     ax <-- 01 06
add al, bh;      ax <-- 01 56
mov x, al
endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

print_4b macro x
mov ah, 02
mov dl, x
add dl, '0'
int 21h
endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

print_8b macro x
; assuming x <-- 56

; printing higher digit : 
mov dl, x        ; dl <-- 56
ror dl, 04       ; dl <-- 65
and dl, 0fh      ; dl <-- 05
print_4b dl

;printing lower digit
mov dl, x
and dl, 0fh
print_4b dl

endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;#############################################################################
data segment
    a db ?
    b db ?
    lcm_a dw ?
    lcm_b dw ?
    ip_prompt_1 db "Enter first number : $"
    ip_prompt_2 db "Enter second number : $"
    lcm_is db "Lcm of entered numbers is : $"
data ends
;#############################################################################
code segment
assume cs:code, ds:data

start : mov ax, data
        mov ds, ax

        xor ax, ax
        xor bx, bx

        print_msg ip_prompt_1
        input_8b a          ; 1
        println

        print_msg ip_prompt_2
        input_8b b          ; 2
        println

        ; converting both a and b to hex.
        bcd_to_hex_8b a
        bcd_to_hex_8b b


        xor ah, ah          ; 3
        mov al, a
        mov lcm_a, ax       ; 3

        mov al, b           ; 4
        mov lcm_b, ax       ; 4

loopback : mov ax, lcm_a       ; 5
        cmp ax, lcm_b

        jg lcm_a_greater    
        jz lcm_found        ; 7

lcm_b_greater:
mov ax, lcm_a               ; 11
    mov bl, a
    xor bh, bh
    add ax, bx
    mov lcm_a, ax           ; 11
    jmp loopback            ; 12

lcm_a_greater:
    mov ax, lcm_b           ; 6
    mov bl, b
    xor bh, bh
    add ax, bx
    mov lcm_b, ax           ; 6
    jmp loopback

lcm_found :
    mov cx, lcm_a

    hex_to_bcd_8b ch         ; this logic might fail for 16 bits answer
    hex_to_bcd_8b cl         ; replace these two line with conversion from 16bit hex to bcd
    
    print_msg lcm_is
    print_8b ch
    print_8b cl

terminate: mov ah, 4ch
           int 21h
code ends
end start
;#############################################################################