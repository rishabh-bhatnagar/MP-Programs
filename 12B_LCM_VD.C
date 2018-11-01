#include <stdio.h>
#include <conio.h>

// Function for reference
// https://www.programiz.com/c-programming/examples/hcf-recursion
int hcf(int n1, int n2)
{
    if (n2 != 0)
       return hcf(n2, n1%n2);
    else 
       return n1;
}

int main(){
    int num1, num2, lcm, gcd;
    int on1, on2; //store num1,num2 here for backup
    printf("Enter two nums:");
    scanf("%d%d", &num1, &num2);

    // preserve original values of num1, num2
    on1 = num1;
    on2 = num2;

    // LCM = num1 * num2 / gcd

    hcf_function:asm{

        cmp num2, 00
        jne recurse

        mov cx, num1
        mov gcd, cx
        jmp gcd_found
    }


    recurse:asm{
        mov ax, num1
        mov bx, num2
        div bx
        // remainder in dx

        mov cx, num2
        mov num1, cx

        mov num2, dx
    /*DEBUG*/
    }
    printf("num1: %d, num2: %d\n", num1, num2);
    asm{
    /*DEBUG*/
        jmp hcf_function
    }

    gcd_found:asm{
        mov ax, on1
        mov bx, gcd
        div bx // num1 /gcd

        mov bx, on2
        mul bx // num1/gcd * num2

        mov lcm, ax
    }

    printf("LCM: %d\n", lcm);
    getch();
    return 0;
}