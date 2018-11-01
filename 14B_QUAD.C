#include <stdio.h>
#include <conio.h>

int main(){
    int a,b,c,root;
    int b2, a4ac;
    printf("Enter a,b,c: ");
    scanf("%d%d%d",&a,&b,&c);

    // root = b*b - 4*a*c

    asm{
        mov ax, b
        mov bx, b
        mul bx
        mov b2, ax

        mov ax, 4
        mov bx, a
        mul bx
        mov bx, c
        mul bx
        mov a4ac, ax

        mov ax, b2
        sub ax, a4ac
        mov root, ax
    }


    printf("Root: %d\n", root);
    getch();
    return 0;
}
