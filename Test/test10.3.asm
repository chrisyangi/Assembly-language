assume cs:code  
  
data segment  
    db 10 dup(0)  
data ends  
  
code segment  
start:  
    mov ax,6666  
    mov bx,data  
    mov ds,bx  
    mov si,0     ;ds:[si]->data
    call dtoc  
  
    mov dh,8     ;row
    mov dl,3     ;column
    mov cl,02h   ;color 
    call show_str  
  
    mov ax,4c00h  
    int 21h  
  
dtoc:  
    push ax  
    push di  
    push cx  
    push dx  
    push si  
	
    mov di,0    ; 记录入栈多少次，就是有多少位数  
s1:  
    mov cx,10   ; cx为除数  
    mov dx,0  
    div cx  
  
    mov cx,ax   ;用cx判断商是否为0  
    jcxz s2  
  
    add dx,30h  ;余数+30H = 对应余数的ASCII码
    push dx     ;把求得的ACSII入栈  
    inc di      ;统计入栈次数
    jmp short s1  
s2:  
    add dx,30h  ;最后一次并入栈  
    push dx  
    inc di  
  
    mov cx,di   ;di次数做为循环条件
s3:  
    pop ax  
    mov ds:[si],al ;ACSII码只占用了低8位,所以用al即可  
    inc si  
    loop s3  
  
    pop si  
    pop dx  
    pop cx  
    pop di  
    pop ax  
    ret  
  
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