assume cs:code,ds:data,ss:stack

data segment
	db 'administrator!!!'  ; 1 of 16 bytes 
	db 02h,24h,71h	       ; 1 of 3 bytes 
data ends

stack segment
	dw 8 dup(0)
stack ends

code segment
start:
	mov ax,data
	mov ds,ax
	mov ax,stack
	mov ss,ax
	mov sp,10h           ; initial   8 words = 16 bytes   point the stack top
	
	mov ax,0b872h
	mov bx,0
	mov cx,3
s:
	push cx
	push ax
	push bx 
	mov es,ax
	mov si,0			  ; index for the ASCII
	mov di,0			  ; record the column numbers
	mov cx,10h
s1:						  ; loop for the ASCII
	mov al,ds:[si]
	mov es:[di],al
	inc si
	add di,2
	loop s1
	
	pop bx
	mov al,ds:10h[bx]
	inc bx
	mov di,1
	mov cx,10h
s2:						   ; loop for the color   02h 24h 71h
	mov es:[di],al
	add di,2
	loop s2
	
	pop ax
	add ax,0ah
	pop cx
	loop s
	
	mov ax,4c00h
	int 21h
code ends
end start