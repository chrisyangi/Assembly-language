assume cs:code,ds:data  
  
data segment  
    db 'chris for test10.1!',0     ; output :0b800h
data ends  
  
code segment  
start:    
    mov dh,8    ; row
    mov dl,3    ; column
    mov cl,02h  ; color 
    mov ax,data  
    mov ds,ax  
    mov si,0    ;loop for the byte  
    call show_str  
  
    mov ax,4c00h  
    int 21h  
show_str:  
	push ax
	push es
	push di
	push cx

	mov ax,0b800h
	mov es,ax
    mov di,0     ; loop for the input the area
	mov bx,0506h
	mov al,cl    ; save the color
	mov ch,0
s:
	mov cl,ds:[si]
	jcxz ok
	mov es:[bx+di],cl
	mov es:[bx+di+1],al
	inc si
	add di,2
	jmp short s
	
ok: 
	pop cx
	pop di
	pop es
	pop ax
	ret
	
code ends  
  
end start