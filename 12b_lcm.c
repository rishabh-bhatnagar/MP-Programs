#include "stdio.h"
int main(void)
{
	int a, b, temp, result;
	printf("Enter two numbers : ");
	scanf("%d, %d", &a, &b);
	start:asm{
	      mov ax, a
	      mov bx, b
	}

	Compare: asm{
		CMP AX,BX       			 //Compare the two numbers.
	JE lcm          			 //If equal, go to lcm label.
	JB EXCG         			 //If first number is below than second,
					     //go to EXCG label.
     }
    Body: asm{
	mov dx, 0h
	DIV BX         		    //Divide the first number by second number.
	CMP DX,0        		//Compare remainder is zero or not. (AX=Q ; DX=R)
	JE lcm       			//If zero, jump to lcm label.
	MOV AX,DX       		//If non-zero, move remainder to AX.
	JMP Compare         			//Jump to Compare label.
    }
    EXCG: asm{
	XCHG AX,BX     		//Exchange the remainder and quotient.
	JMP Body       		 //Jump to Body.
    }

	lcm: asm{
      // now, bx stores gcd value
      //Since, lcm*gcd = a*b
		mov ax, a
      mul b
      div bx
      mov result, ax
    }

	printf("lcm of %d, %d : %d", a, b, result);
	getch();
	return 0;
}