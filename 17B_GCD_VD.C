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
    int num1, num2, gcd;
    printf("Enter 2 nums: ");
    scanf("%d%d", &num1, &num2);

    hcf_function:asm{


        cmp num2, 00
        
        // if n2 !=0, recurse
        jne recurse

        // else, return n1
        mov cx, num1
        mov gcd, cx
        jmp end_asm
    }

    recurse:asm{
        // do num1 = num2
        // do num2 = num1%num2

        mov ax, num1
        mov bx, num2
        div bx
        // remainder in dx

        // assign new value to num1
        mov cx, num2    // do this since
        mov num1, cx    // mov MEM, MEM is invalid

        // assign new value to num2
        mov num2, dx
    /*DEBUG*/
    }
    printf("num1: %d, num2: %d\n", num1, num2);
    asm{
    /*DEBUG*/
        jmp hcf_function
    }


    end_asm:
    printf("GCD: %d\n", gcd);
    getch();
    return 0;
}