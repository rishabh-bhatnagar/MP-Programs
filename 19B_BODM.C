#include <stdio.h>
#include <conio.h>

int main(){
    int A,B,C,D;
    int answer;
    printf("Enter A,B,C,D: ");
    scanf("%d %d %d %d", &A, &B, &C, &D);

    asm{
        // A - B * C + D

        mov ax, B
        mov bx, C
        mul bx      // B * C
        // ans in dx, ax
        // if ans is less than 65535, 
        // then ans is only in ax

        /*DEBUG*/ mov answer, ax

        mov bx, A
        sub bx, answer  // A - (B * C)
        mov answer, bx

        mov bx, D
        add answer, bx  // (A - (B * C)) + D

    }

    printf("answer: %d\n", answer);
    getch();
    return 0;
}