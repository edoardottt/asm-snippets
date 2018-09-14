.data 
numero: .word
vettore: .word 0,1,2,3,4,5,6,7,8,9
dim: .word 10
si: .asciiz "si il valore è presente"
no:.asciiz "no, il valore non è presente"

.text
.globl main
	main:
	#preparo codice
	la $t0,vettore
	lw $t1,dim
	
	li $v0,5
	la $a0,numero
	syscall
	sw $v0,numero
	lw $t2,numero
	addi $s1,$s1,0
	jal ciclo
	#stampa no
	stampano:
	la $a0,no
	li $v0,4
	syscall
	li $v0, 10
	syscall
	
	#stampa si
	stampasi:
	la $a0,si
	li $v0,4
	syscall
	li $v0, 10
	syscall
	
	ciclo:
		bge  $s1,$t1,fine
		
		#salvo valori sullo stack
		sub $sp,$sp,8
		sw $s1,4($sp)
		sw $ra,0($sp)
		
		lw $t3,0($t0)
		beq $t3,$t2,stampasi
		add $t0,$t0,4
		addi $s1,$s1,1
		jal ciclo
		
		#carico valori dallo stack
		lw $s1,4($sp)
		lw $ra,0($sp)
		add $sp,$sp,8
	fine:
	jr $ra
	
	
