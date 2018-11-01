#include <stdio.h>
#include <conio.h>

int main(){
    int basic_pay = 100;
    int salary = 0;
    printf("Enter basic pay: ");
    scanf("%d", &basic_pay);

    asm{

        // formula
        // salary  = 
        // basic_pay            (1)
        // + 0.5 * basic_pay    (2)
        // + 0.05 * basic_pay   (3)
        // - 0.1 * basic_pay    (4)


        // step 1
            mov ax, basic_pay
            add salary, ax // since add mem, mem doesn't work

        // step 2
            mov ax, basic_pay
            mov bl, 02
            div bl
            // ax/02 == 50% ax

            mov ah, 00      // discard remainder
            add salary, ax     // quotient in al gets added


        // step 3
            mov ax, basic_pay
            mov bl, 20
            div bl
            // ax/20 == 5% ax

            mov ah, 00
            add salary, ax

        // step 4
            mov ax, basic_pay
            mov bl, 10
            div bl
            // ax/10 == 10% ax

            mov ah, 00
            sub salary, ax

    }


    printf("Salary: %d\n", salary);

    getch();
    return 0;
}