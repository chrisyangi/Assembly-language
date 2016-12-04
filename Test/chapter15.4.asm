assume cs:code

data segment
	dw 0,0
data ends

stack segment
	db 128 dup(0)
stack ends
	
code segment
start:
	mov ax,stack
	mov ss,ax
	mov sp,128
	
	mov ax,data
	mov ds,ax
	
	mov ax,0
	mov es,ax
	push es:[9*4]
	pop ds:[0]
	push es:[9*4+2]
	pop ds:[2]				;  保存原来的int 9 地址 ，以便后续恢复
	
	mov word ptr es:[9*4],offset int9
	mov es:[9*4+2],cs		;  在中断向量表中设置新的int 9中断例程的入口地址
	
	mov ax,0b800h
	mov es,ax
	mov ah,'a'
s:
	mov es:[160*12+40*12],ah ; 在显示缓冲区显示字符
	call delay
	inc ah
	cmp ah,'z'
	jna s
	
	mov ax,0
	mov es,ax 
	
	push ds:[0]
	pop es:[9*4]
	push ds:[2]
	pop es:[9*4+2]			; 还原int 9的中断向量表地址
	
	mov ax,4c00h
	int 21h
	
delay:					;延时子程序，根据CPU速度更改具体数值		
	push ax
	push dx
	mov dx,10h
	mov ax,0
s1:
	sub ax,1
	sbb dx,0
	cmp ax,0
	jne s1
	cmp dx,0
	jne s1
	pop dx
	pop ax
	ret
	
int9:
	push ax
	push bx
	push es
	in al,60h
	pushf
	
	pushf
	pop bx
	and bh,11111100b
	push bx
	popf
	call dword ptr ds:[0]	;调用原来的int 9 终端例程
	cmp al,1
	jne int9ret
	
	mov ax,0b800h
	mov es,ax
	inc byte ptr es:[160*12+40*12+1]
	
int9ret:
	pop es
	pop bx
	pop ax
	iret
code ends
end start
