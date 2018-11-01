#include <stdio.h>
#include <conio.h>

int main(){
    int num1, num2, num3, avg;
    printf("Enter 3 nums: ");
    scanf("%d%d%d", &num1, &num2, &num3);

    asm{
        mov ax, num1
        add ax, num2
        add ax, num3

        mov bx, 0003

        div bx
        // quo in ax, remainder in dx

        mov avg, ax
    }

    printf("Avg: %d\n", avg);
    getch();
    return 0;
}