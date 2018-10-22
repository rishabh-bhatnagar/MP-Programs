#include<stdio.h>
#include<conio.h>
void main(){
 int a, b, c,  result;
 int x = 3;
 clrscr();
 printf("Enter a, b, c ");
 scanf("%d%d%d", &a, &b, &c);
 asm{
   mov ax, a
   add ax, b
   add ax, c
   div x
   mov result, ax
 }
 printf("Result = %d", result);
 getch();
}
