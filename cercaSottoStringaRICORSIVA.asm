.data
testo: .space 100
query: .space 100
.text
.globl main
main:
	#leggo testo in input
	li $v0,8
	la $a0,testo
	li $a1,100
	syscall
	
	#leggo query in input
	li $v0,8
	la $a0,query
	li $a1,10
	syscall
	
	la $t0,testo
	la $t1,query
	
	#preparo offset
	addi $s0,$s0,0  #N
	addi $s1,$s1,0  #M
	
	jal cerca
	
	#stampa
	stampa:
		li $v0,1
		move $a0,$t5
		syscall
		li $v0,10
		syscall
	
	cerca:
		lb $t2,0($t0)
		lb $t3,0($t1)
		beq $t3,'\0',tornoN
		beq $t3,'\n',tornoN
		beq $t2,'\0',tornoMenoUno
		beq $t2,'\n',tornoMenoUno
		sub $sp,$sp,4
		sw $ra,0($sp)
		bne $t2,$t3,incremento
		beq $t2,$t3,secondaLettera
		jal cerca
	
	incremento:
		addi $t5,$t5,1
		addi $t0,$t0,1
		addi $s1,$zero,0
		add $t1,$t1,$s1
		jal cerca
	
	secondaLettera:
		addi $t0,$t0,1
		addi $t1,$t1,1
		jal cerca
		
	tornoN:
		move $s0,$t5
		lw $ra,0($sp)
		add $sp,$sp,4
		jr $ra
		
	tornoMenoUno:
		addi $t5,$zero,-1
		lw $ra,0($sp)
		add $sp,$sp,4
		jr $ra
		
		
	