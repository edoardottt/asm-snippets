# NON RUNNARE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!	
.data
stringa: .space 100
elemento: .space 1
fineS: .word 3
.text
la $a0,stringa
li $a1,100
li $a2,0
lw $t0,fineS
input:
	beq $v0,$t0,char
	li $v0,8
	syscall
	sw $v0,0($a0)
	addi $a0,$a0,4
	j input
char:
	la $t1,elemento
	li $v0,8
	syscall
	sw $v0,0($t1)
	la $a0,stringa
scorri:
	beq $t2,$t0,fine
	jal leggi_elemento
	beq $t2,$t1,stampaIndice
	addi $a2,$a2,1
	addi $a0,$a0,4
	j scorri
	
leggi_elemento:
	subi $sp,$sp,4
	sw $ra,0($sp)
	
	lw $t2,0($a0)
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
stampaIndice:
	li $v0,1
	move $a0,$a2
	syscall
	li $v0,4
	li $a0,32
	syscall
fine:
	li $v0,10
	syscall