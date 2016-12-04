assume cs:code

data segment
	db "beginner's All-purpose Symbolic Instruction Code.",0
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	mov si,0		;ds:[si] -> data
	call letterc
	mov ax,4c00h
	int 21h

letterc:
	push si
s:
	mov al,[si]
	cmp al,0
	je ok			;  if (al)=0   End!
	
	mov ah,'a'
	cmp al,ah
	jb next			;   (al)'s ASCII < 'a'  jump!
	
	mov ah,'z'
	cmp al,ah
	ja next			;   (al)'s ASCII > 'z'  jump!
	
	and al,11011111B;    sub 32 for char from 'a' to 'z'
	mov [si],al		

next:
	inc si
	jmp short s

ok:
	pop si
	ret
	
code ends
end start