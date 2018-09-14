# CONTA ELEMENTI IN VETTORE ( ENTRAMBI DATI IN INPUT )
# con funzioni e salvataggio su stack pointer

.data
vettore: .space 100

.text
	li $t1,0
riempi:
	li $v0,5
	syscall
	beq $v0,$t1,elemento
	sw $v0,vettore($t0)
	addi $t0,$t0,4
	j riempi
elemento:
	la $a0,vettore
	lw $a1,vettore($t1)
	li $v0,5
	syscall
	move $t3,$v0
scandisci:
	beq $a1,$t1,stampa
	lw $a1,0($a0)
	jal verifica
	addi $a0,$a0,4
	j scandisci
verifica:
	subi $sp,$sp,8
	sw $ra,0($sp)
	sw $a1,4($sp)
	
	beq $a1,$t3,aggiungi
	
	lw $ra,0($sp)
	lw $a1,4($sp)
	addi $sp,$sp,8
	jr $ra
aggiungi:
	addi $s2,$s2,1
	
	lw $ra,0($sp)
	lw $a1,4($sp)
	addi $sp,$sp,8
	jr $ra
stampa:
	li $v0,1
	move $a0,$s2
	syscall
	li $v0,10
	syscall
	
	
	
	
	
	
	