assume cs:code
				;程序要求：从CMOS RAM的8号单元读出当月份的BCD码
code segment
start:				
	mov al,8		; 月份对应内存单元为8号单元
	out 70h,al
	in al,71h
	
	mov ah,al		;  
	mov cl,4
	shr ah,cl		;  右移四位之后，ah中为月份中的十位（4位二进制数也就是十位的BCD码）
	and al,00001111b	;  将al中的高四位置0，只保留低四位（对应的四位二进制个位）
	
	add ah,30h
	add al,30h
	
	mov bx,0b800h	;   显示缓冲区对应内存中的位置
	mov es,bx
	mov byte ptr es:[160*12+40*2],ah	;显示十位数，低地址对应高4位（十位）	
	mov byte ptr es:[160*12+40*2+2],al	;显示个位数
	
	mov ax,4c00h
	int 21h
code ends
end start
