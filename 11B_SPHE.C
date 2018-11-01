#include <stdio.h>
#include <conio.h>

int main(){
    int radius, area;
    printf("Enter radius of circle: ");
    scanf("%d", &radius);

    // area = 4 * 22 * r * r / 7

    asm{
        mov ax, radius
        mov bx, radius
        mul bx

        mov bx, 4
        mul bx

        mov bx, 22
        mul bx

        mov bx, 7
        div bx

        mov area, ax
    }

    printf("Area: %d\n", area);

    getch();
    return 0;
}
