#include <stdio.h>
#include <conio.h>
int main(){
    int num;
    int prime_flag = 0, iter_var=2;
    int half_num=2;


    printf("Enter num:");
    scanf("%d", &num);
    asm{

        // loop should iterate for 
        // 2 to num/2
        // ie cx = num/2 - 1

        xor dx, dx
        mov ax, num
        mov bx, 0002
        div bx

        // move quotient in half_num
        mov half_num, ax

        // set cx for num/2-1 iterations
        dec half_num
        mov cx, half_num

        // init loop
        mov iter_var, 0002
    }

    back:asm{// loop start here

        //function, where x is param
        //copy value in x, then copy this code
                xor dx, dx               
                mov ax, num              
                mov bx, iter_var
                // setup dividend, divisor
                                         
                div bx                   
                cmp dx, 00               
                jz not_prime             
                                         
                // else do nothing   

        inc iter_var
        // increment iter_var

        loop back
        // go back to loop


        // if you reach here, without going to not_prime
        // then it is prime
        jmp prime

    }


    not_prime:asm{
        
        mov prime_flag, 0
        jmp exit_asm
    }

    prime:asm{
        
        mov prime_flag, 1
        jmp exit_asm
    }

    exit_asm:
    if(prime_flag == 1)
        printf("Prime\n");
    else
        printf("Not Prime\n");

    getch();
    return 0;
}