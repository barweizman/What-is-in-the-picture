org 100h

jmp start
	
	num db ?
	sum db 0
	msg db "Sum = ", '$'
	pointless dw 0 
	str1 db 30 dup (?)  

inputstr: 
	push bp
	mov bp,sp
	push ax
	push bx
	mov bx,[bp+4]
	k1: 
		mov ah,1
		int 21h
		cmp al,0dh
			je k2
		mov [bx],al
		inc bx
		jmp k1
	k2: 
		mov byte ptr[bx],'$'
		pop bx
		pop ax
		pop bp
		ret 2
		
strtoint:
    push bp
    mov bp,sp
    push ax
    push bx
    push dx
	mov ax,0
    mov dl,10
    mov dh,0
    mov bx,[bp+4]

	Blueportal:
        cmp byte ptr [bx],'$'
			je ennnd 
        mul dl
        mov dh,[bx]
        sub dh,30h
        add al,dh
        inc bx 
        jmp Blueportal

		ennnd:
            mov bx,[bp+6]
            mov [bx],al    
            pop dx
            pop bx
            pop ax
            pop bp
            ret 4
			
print:
	push ax
	mov ah,9
	int 21h
	pop ax
	ret
	
linedown:
	push ax
	push dx
	mov ah,2
	mov dl,13
	int 21h
	mov dl,10
	int 21h
	pop dx
	pop ax 
	ret

inttostr:
    push bp
    mov bp,sp
    push ax
    push bx
    push dx
    push cx
    mov al,[bp+6]
    mov ah,0
    mov dl,10
    mov bx,[bp+4]
    mov cx,0
    cmp al,0

	Blueportal1:
        cmp al,0
			Je beforendd
        mov ah,0
        div dl
        push ax
        inc cx  
        Jmp Blueportal1
         
		beforendd:
			pop ax
			add ah,30h
			mov [bx],ah
			inc bx
			inc cx
			loop beforendd
			mov byte ptr [bx],'$'   

			endd1:
			pop cx  
			pop dx                                   
			pop bx
			pop ax
			pop bp
			ret  
	
start:
    mov ax,@data
    mov ds,ax
    
    push offset [str1]
	call inputstr
	push offset [str1]
	call strtoint
	mov num, al
	call linedown
	mov cl, num
	mov byte ptr[pointless], cl
	sumloop:
		mov al, byte ptr[pointless]
		mov ax, pointless
		mov cl, 10
		div cx
		cmp al, 0
			je outloop
			jne sumloop1
	sumloop1:
		add sum, al
		jmp sumloop
	outloop:
		mov dx, offset [msg]
		call print
		mov ax, word ptr[num]
		push ax
		push offset[str1]
		call inttostr
		push offset[str1]
		call print

ret