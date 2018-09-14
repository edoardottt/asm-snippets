.data
stringa1: .space 101
stringa2: .space 101
prima: .asciiz "prima"
seconda :.asciiz "seconda"
uguali : .asciiz "uguali"
.text
.globl main
main:
	#lettura stringhe in input
	li $v0,8
	la $a0,stringa1
	li $a1,100
	syscall
	li $v0,8
	la $a0,stringa2
	la $a1,100
	syscall
	la $t0,stringa1
	la $t1,stringa2
	
	jal conta
	
	#stampa
	beq $t4,1,stampaPrima
	beq $t4,0,stampaUguali
	beq $t4,-1,stampaSeconda
	
	stampaPrima:
		li $v0,4
		la $a0,prima
		syscall
		li $v0,10
		syscall
	stampaUguali:
		li $v0,4
		la $a0,uguali
		syscall
		li $v0,10
		syscall
	stampaSeconda:
		li $v0,4
		la $a0,seconda
		syscall
		li $v0,10
		syscall
	
	
	conta:
		sub $sp,$sp,4
		sw $ra,0($sp)
		lb $t2,0($t0)
		lb $t3,0($t1)
		beq $t2,0,controlloY
		beq $t2,'\n',controlloY
		beq $t3,0,controlloX
		beq $t3,'\n',controlloX
		blt $t2,$t3,primaMinoreSeconda
		bgt $t2,$t3,primaMaggioreSeconda
		beq $t2,$t3,continua
		jal conta
		
		
	controlloY:
		beq $t3,0,ugualii
		beq $t3,'\n',ugualii
		li $t4,-1
		j fine
		
	controlloX:
		beq $t2,0,uguali
		beq $t2,'\n',ugualii
		li $t4,1
		j fine
		
	ugualii:
		li $t4,0
		j fine
	
	primaMinoreSeconda:
		li $t4,-1
		j fine
		
	primaMaggioreSeconda:
		li $t4,1
		j fine
	continua:
		addi $t0,$t0,1
		addi $t1,$t1,1
		jal conta
	fine:
		lw $ra,0($sp)
		add $sp,$sp,4
		jr $ra
		
