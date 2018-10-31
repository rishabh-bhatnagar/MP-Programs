void main()
{
	int x,y,res;
	clrscr();
	printf(&quot;Enter x,y:\n&quot;);
	scanf(&quot;%d%d&quot;,&amp;x,&amp;y);
	asm {
		mov ax,01
		mov bx,x
		mov cx,y
	}

	L1: asm {
		mul bx
		loop L1
	}
	L2: asm {
		
	}
	printf(&quot;Result=%d&quot;,res);
	getch();
}