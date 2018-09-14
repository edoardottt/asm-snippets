.data 
x: .word 
y:.word
.text
.globl main
main:
	#x in input
	li $v0,5
	la $a0,x
	syscall
	sw $v0,x
	lw $t0,x
	
	addi $v0,$zero,0 #resetto $v0
	
	#y in input
	li $v0,5
	la $a0,y
	syscall
	sw $v0,y
	lw $t1,y
	
	li $t2,2 #salvo valore due per la divisione
	
	jal log    #chiamata ricorsiva
	
	stampa:
		li $v0,1
		move $a0,$t3
		syscall
		li $v0,10
		syscall
	
	log:
	
		beq $t0,1,controlloy
		
		#salvo valori sullto stack
		sub $sp,$sp,4
		sw $ra,0($sp)
		
		beq $t1,1,controllox
		div $t0,$t0,$t2
		addi $t3,$t3,1
		jal log
		
		
	controllox:
		beq $t0,1,fine
		bgt $t0,1,xmezzi
	xmezzi:
		div $t0,$t0,$t2
		addi $t3,$t3,1
		jal log
	controlloy:
		beq $t1,1,fine
		bgt $t1,1,ymezzi
	
	ymezzi:
		div $t1,$t1,$t2
		addi $t3,$t3,1
		jal log
	fine:
	#carico valori dallo stack
		lw $ra,0($sp)
		add $sp,$sp,4
		jr $ra
