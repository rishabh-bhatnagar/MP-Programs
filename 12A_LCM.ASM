;AIM : take 8bit number and store as hex

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

;#############################################################################
data segment
    a db ?
    ip_prompt_1 db "Enter a number : $"
    successful db "Number converted successfully.$"
data ends
;#############################################################################
code segment
assume cs:code, ds:data

start : mov ax, data
        mov ds, ax

        print_msg ip_prompt_1
        input_8b a          ; 1
        println

        bcd_to_hex_8b a
        
        print_msg successful

terminate:mov ah, 4ch
          int 21h
code ends
end start
;#############################################################################