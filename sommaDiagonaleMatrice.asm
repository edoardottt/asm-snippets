# SOMMA VALORI SU UNA DIAGONALE DI UNA MATRICE QUADRATA 20 X 20

.data
matrice: .word 400:1
lato: .word 20

.text

main:
	li $t0,0               #indice
	lw $t1,lato  
	mul $t1,$t1,$t1
	sll $t1,$t1,2          #indice finale
	
	#riempimento valori matrice
	
	li $t5,0
	li $t6,1
ciclo:	
	bge $t5,$t1,loop
	sw  $t6,matrice($t5)
	addi $t5,$t5,4
	j ciclo
loop:
	bge $t0,$t1,fine
	lw $t3,matrice($t0)    # elemento
	add $t4,$t4,$t3        # somma
	addi $t0,$t0,84        # aggiornamento indice [ x+(21 words da saltare * 4 byte)]
	j loop
fine:
	li $v0,1
	move $a0,$t4          #risultato = 20
	syscall

	
	