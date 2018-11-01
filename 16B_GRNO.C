#include <stdio.h>
#include <conio.h>
int main(){
    int a,b,c, large;
    int n1,n2,n3;
    printf("Enter 3 nums: ");
    scanf("%d%d%d",&a,&b,&c);

    // For explaination and comments 
    // of code, go to end of file
    asm{
        // BLOCK (a,b,c)
            mov ax, a
            mov n1, ax
            mov ax, b
            mov n2, ax
            mov ax, c
            mov n3, ax

            mov ax, n1
            cmp ax, n2
            jl  end_compare_a
            mov ax, n1
            cmp ax, n3
            jl end_compare_a
            mov ax, n1
            mov large, ax
            jmp largest_found
        // BLOCK (a,b,c)        
        }

    end_compare_a:asm{
        // BLOCK (b, a, c)
            mov ax, b
            mov n1, ax
            mov ax, a
            mov n2, ax
            mov ax, c
            mov n3, ax

            mov ax, n1
            cmp ax, n2
            jl  end_compare_b
            mov ax, n1
            cmp ax, n3
            jl end_compare_b
            mov ax, n1
            mov large, ax
            jmp largest_found
        // BLOCK (b, a, c)
        }
    end_compare_b:asm{

        // BLOCK (c, a, b)
            mov ax, c
            mov n1, ax
            mov ax, a
            mov n2, ax
            mov ax, b
            mov n3, ax

            mov ax, n1
            cmp ax, n2
            jl  end_compare_b
            mov ax, n1
            cmp ax, n3
            jl end_compare_b
            mov ax, n1
            mov large, ax
            jmp largest_found
        // BLOCK (c, a, b)
        }
    end_compare_c:asm{
    }


    largest_found:
    printf("Greater num is: %d\n", large);

    getch();
    return 0;
}

/*
    // original asm code
        // BLOCK (n1, n2, n3)
        // C Code
        // if n1>=n2 && n1>=n3
        //     return n1
        // else
        //     quit

        // Repeat this block three times
        // ie
        // if a>=b && a>=c
        // if b>=c && b>=a
        // if c>=a && c>=b
        // Also, change else label to unique
        // for eg, for comparing a, change it to 
        // done_cmp_a

        mov ax, n1
        cmp ax, n2

        //else
        jl  end_compare

        //if n1>=n2
        mov ax, n1
        cmp ax, n3

        // else
        jl end_compare
        // if n1>=n3

        // if we reach here, 
        // then n1 is greater than n2 and n3 both
        mov large, n1
        jmp largest_found
        // BLOCK (n1, n2, n3)
*/