.data
.text
.globl main
main:
	#lettura X in input
	li $v0,5
	syscall
	move $t0,$v0
	
	addi $v0,$zero,0 #azzero $v0
	
	#lettura Y in input
	li $v0,5
	syscall
	move $t1,$v0
	
	jal conta
	
	#stampa
	li $v0,1
	move $a0,$t3
	syscall
	li $v0,10
	syscall
	
	conta:
		beq $t0,0,fine
		beq $t1,0,fine
		subi $sp,$sp,4
		sw $ra,0($sp)
		andi $t4,$t0,1
		andi $t5,$t1,1
		beq $t4,$t5,lsbUguali
		bne $t4,$t5,lsbDiversi
		jal conta
		
	lsbUguali:
		div $t0,$t0,2
		div $t1,$t1,2
		addi $t3,$t3,1
		jal conta
		
	lsbDiversi:
		div $t0,$t0,2
		div $t1,$t1,2
		jal conta
		
	fine:
		lw $ra,0($sp)
		add $sp,$sp,4
		jr $ra
	
	