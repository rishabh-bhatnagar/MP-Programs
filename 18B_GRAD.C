#include <stdio.h>
#include <conio.h>

int main(){
    int marks;
    char grade;
    printf("Enter marks:");
    scanf("%d", &marks);

    // Grade:
    // A marks>80
    // B 79 > marks > 60
    // C 59 > marks > 40
    // F      marks > 39

    asm{
        mov ax, marks

        cmp ax, 80
        jge g_A

        cmp ax, 60
        jge g_B

        cmp ax, 40
        jge g_C

        // else, grade is fail
        jmp g_F
    }

    g_A:asm{
        mov grade, 'A'
        jmp end_asm
    }

    g_B:asm{
        mov grade, 'B'
        jmp end_asm
    }

    g_C:asm{
        mov grade, 'C'
        jmp end_asm
    }

    g_F:asm{
        mov grade, 'F'
        jmp end_asm
    }


    end_asm:
    printf("Grade: %c\n", grade);

    getch();
    return 0;
}