# MATRICE RISULTANTE IL PRODOTTO VETTORE COLONNA X VETTORE RIGA
.data
riga: .word 1,2,3,4
colonna: .word 2,3,4
matrice: .word 0:12
.text
li $t0,0
li $t1,0
li $t2,0
li $t9,0
scorri:
	beq $t2,12,stampa
	sll $t3,$t0,2
	lw $t6,riga($t3)
	sll $t4,$t1,2
	lw $t7,colonna($t4)
	mul $t8,$t6,$t7
	sll $t5,$t2,2
	sw $t8,matrice($t5)
	addi $t0,$t0,1
	addi $t2,$t2,1
	beq $t0,4,colonnaSucc
	j scorri
	
colonnaSucc:
	li $t0,0
	addi $t1,$t1,1
	j scorri
stampa:
	
	beq $t9,12,fine
	sll $s1,$t9,2
	lw $s0,matrice($s1)
	li $v0,1
	move $a0,$s0
	syscall
	addi $t9,$t9,1
	j stampa

fine:
	li $v0,10
	syscall
	
	