#include <stdio.h>

int main(int argc, char const *argv[])
{
    int a = 3;
    int b = 5;
    printf("Before swapping:\n");
    printf("a: %d, b: %d\n", a, b);
    asm{
        mov ax, a
        mov a, b
        mov b, ax
    }

    printf("After swapping:\n");
    printf("a: %d, b: %d\n", a, b);
    return 0;
}