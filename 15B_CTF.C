#include <stdio.h>
#include <conio.h>

int main(){
    int Fahrenheit, Centigrade;
    printf("Enter Centigrade:");
    scanf("%d", &Centigrade);

    // F = (C * 9/5) + 32

    asm{
        mov ax, Centigrade
        mov bx, 5
        div bx

        mov bx, 9
        mul bx

        add ax, 32
        mov Fahrenheit, ax
    }

    printf("Fahrenheit: %d\n", Fahrenheit);
    getch();
    return 0;
}
