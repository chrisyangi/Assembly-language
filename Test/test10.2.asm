assume cs:code,ss:stack

stack segment
	dw 8 dup(0)
stack ends

code segment
start:
	mov ax,4240h
	mov dx,000fh
	mov cx,0ah
	call divdw
	
	mov ax,4c00h
	int 21h
divdw:
	push ax
	
	mov ax,dx
	mov dx,0
	div cx          ;得出高16位放在ax中
	
	mov bx,ax
	pop ax
	div cx			;得出低16位和余数
	
	mov cx,dx
	mov dx,bx
	pop ax
	ret
	
code ends
end start