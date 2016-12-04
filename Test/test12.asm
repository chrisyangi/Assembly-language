assume cs:code

code segment 
start:
	mov ax,cs
	mov ds,ax
	mov si,offset do0	    ;  original : ds:si
	mov ax,0
	mov es,ax
	mov di,200h				;  terminal : es:di         ds:si->es:di
	mov cx,offset do0end-offset do0
    cld  					;  set TF = 0   Direct >>>>>>
	rep movsb
	
	mov ax,0
	mov es,ax
	mov word ptr es:[0*4],200h
	mov word ptr es:[0*4+2],0
	
	mov ax,1000h
	mov bh,1
	div bh
	
	mov ax,4c00h
	int 21h

do0:
	jmp short do0start
	db "overflow!"

do0start:
	mov ax,cx
	mov ds,ax
	mov si,202h  		;  ds:si point to the string
	mov ax,0b800h
	mov es,ax
	mov di,12*160+36*2	; set es:di point the center
	mov cx,9
s:
	mov al,[si]
	mov es:[di],al
	inc si
	add di,2
	loop s
	
	mov ax,4c00h
	int 21h
do0end:
	nop
	
code ends
end start