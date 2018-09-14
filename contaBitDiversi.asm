.data
.text
.globl main
main:
	#lettura X in input
	li $v0,5
	syscall
	move $t0,$v0
	
	#lettura Y in input
	li $v0,5
	syscall
	move $t1,$v0
	
	li $t6,2 #per la divisione
	
	jal conta
	
	#stampa 
	li $v0,1
	move $a0,$t5
	syscall
	li $v0,10
	syscall
	
	conta:
		#caso base
		beq $t0,0,controlloy
		
		#salvo valori su stack
		sub $sp,$sp,4
		sw $ra,0($sp)
		
		andi $s0,$t0,1
		andi $s1,$t1,1
		xor $t3,$s0,$s1
		add $t5,$t5,$t3
		div $t0,$t0,$t6
		div $t1,$t1,$t6
		
		jal conta
		
	controlloy:
		beq $t1,0,fine
		jr $ra
	
	fine:
		#carico valori da stack
		lw $ra,0($sp)
		addi $sp,$sp,4
		jr $ra
		
		
		
		
		
		