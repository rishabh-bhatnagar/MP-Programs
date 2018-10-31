Display N natural numbers in descening order and storing it in an array.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Steps :
;   1) take number in hexadecimal :
;   .   for that, store msb in ah, lsb in al
;   .   use aad
;   2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
get_hexa_number macro x
;  x is an 8 bit register.
mov ah, 01

int 21h       ; getting higher byte
sub al, 30h   ; getting ascii equivalent.

mov bl, al    ; saving lower nibble temporarily

int 21h
sub al, 30h   ; getting lower byte in ascii

mov ah, bl
aad           ; bcd in ah and al to hexa in al
mov x, al

endm


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
data segment
prompt db, 10, "Enter a number : $"
array db 10 dup(?)
data ends


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
code segment
assume cs:code, ds:data
start:mov ax, data
mov ds, ax

; displaying prompt message.
mov ah, 09h
mov dx, offset prompt
int 21h
; prompt end

get_hexa_number cl

; cl now has counter
lea bx, array     ; getting physical address of start location of array in bx
                  ; lea is load effective address.
xor si, si

L1:mov bx[si], cl
inc si


xor ah, ah
mov al, cl      ; cl is a hexadecimal number
aam             ; unpack from 0x to decimal as ah:al

; displaying higher 4 bits
mov ch, al
mov dl, ah
mov ah, 02
add dl, 30h
int 21h

mov dl,ch
add dl,30h
int 21h

; printing a space:
mov dl, 20h
int 21h

xor ch,ch

dec cl
cmp cl, 00
jnz L1

code ends
end start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;