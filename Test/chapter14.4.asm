assume cs:code
;����Ҫ�󣺴�CMOS RAM��8�ŵ�Ԫ�������·ݵ�BCD��
code segment
start:				
	mov al,8		; �·ݶ�Ӧ�ڴ浥ԪΪ8�ŵ�Ԫ
	out 70h,al
	in al,71h
	
	mov ah,al		;  
	mov cl,4
	shr ah,cl		;  ������λ֮��ah��Ϊ�·��е�ʮλ��4λ��������Ҳ����ʮλ��BCD�룩
	and al,00001111b;  ��al�еĸ���λ��0��ֻ��������λ����Ӧ����λ�����Ƹ�λ��
	
	add ah,30h
	add al,30h
	
	mov bx,0b800h	;   ��ʾ��������Ӧ�ڴ��е�λ��
	mov es,bx
	mov byte ptr es:[160*12+40*2],ah	;��ʾʮλ��
	mov byte ptr es:[160*12+40*2+2],al	;��ʾ��λ��
	
	mov ax,4c00h
	int 21h
code ends
end start