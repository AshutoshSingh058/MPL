;Write an X86/64 ALP to accept five hexadecimal numbers from the user and store them in an array and display the accepted numbers
; Ahutosh Singh
; Date 20/01/2025


%macro inout 4 
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
%endmacro

%macro exit 0 
	mov rax,60
	mov rdi,0
	syscall
%endmacro

section .data
						
	msg1 db "Write an X86 64bit ALP to accept five hexadecimal numbers from the user and store them in an array and display the accepted numbers."
							
	len1 equ $-msg1
	msg2 db "Enter five hexadecimal numbers : ",10
	len2 equ $-msg2
	msg3 db "Five hexadecimal numbers are : ",10
	len3 equ $-msg3
	newline db 10	
section .bss
	
	asciinum resb 17
	hexnum resq 5

section .code
	global _start
		_start:
		inout 1,1,msg1,len1 			
		inout 1,1,msg2,len2
		mov rcx,5 				
		mov rsi,hexnum				
		next1:
			push rcx			
			push rsi			
			inout 0,0,asciinum,17		
			call ascii2hex			
			pop rsi				
			pop rcx				
			mov [rsi],rbx			
			add rsi,8			
		loop next1
		
		inout 1,1,msg3,len3
		mov rcx,5
		mov rsi,hexnum		
		next2:
			push rcx
			push rsi
			mov rbx,[rsi]
			call hex2ascii
			pop rsi
			pop rcx
			add rsi,8
		loop next2
		exit
		
		ascii2hex:
			mov rsi,asciinum
			mov rbx,0
			mov rcx,16
			
			next3:
				rol rbx,4
				mov al,[rsi]
				cmp al,39h
				jbe sub30h
				sub al,7h
				
				sub30h:
					sub al,30h
					add bl,al
					inc rsi
			loop next3
		ret


		hex2ascii:
			mov rsi,asciinum
			mov rcx,16
			
			next4:
				rol rbx,4
				mov al,bl
				and al,0fh
				cmp al,9
				jbe add30h
				add al,7h
				
				add30h:
					add al,30h
					mov [rsi],al
					inc rsi
			loop next4
			inout 1,1,asciinum,16
			inout 1,1,newline,1
		ret	
