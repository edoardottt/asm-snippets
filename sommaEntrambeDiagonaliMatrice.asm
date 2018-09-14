# SOMMA DIAGONALI DI UNA MATRICE QUADRATA ( ATTENZIONE A NON SOMMARE DUE VOLTE L'UNITà CENTRALE SE LATO DISPARI )

.data
matrice: .word 121:1
lato: .word 11

.text
main:
	li $t0,0              #indiceDX
	li $t7,40              #indiceSX   
	lw $t1,lato
	mul $t1,$t1,$t1
	sll $t1,$t1,2         #indice fine dx
	subi $t8,$t1,40       #indice fine sx
	# calcolo unità da non sommare due volte
	lw $t3,lato
	div $t4,$t3,2
	sll $t3,$t3,2
	mul $t4,$t3,$t4       #righe intere prima della metà
	lw $t3,lato
	div $t5,$t3,2
	sll $t5,$t5,2
	add $t5,$t5,$t4       #offset dell'elemento centrale
	
	#riempimento matrice
	li $t2,0
	li $s1,1
	riempi:
	beq $t2,$t1,scorriDX
	sw $s1,matrice($t2)
	addi $t2,$t2,4
	j riempi
scorriDX:
	bge $t0,$t1,scorriSX   #scorro la diagonale di dx e quando è finita passo all'altra
	lw $t9,matrice($t0)
	add $s0,$s0,$t9
	addi $t0,$t0,48
	j scorriDX
scorriSX:
	bge $t7,$t8,fine      # scorro la diagonale di sx (facendo attenzione a non sommare l'elemento due volte l'elemento
	beq $t7,$t5,saltasomma# in comune e quando ho finito salto a fine
	lw $s2,matrice($t7)
	add $s0,$s0,$s2
	addi $t7,$t7,40
	j scorriSX
	
saltasomma:
	addi $t7,$t7,40
	j scorriSX
fine:
	li $v0,1             # stampa del risultato: -se lato pari: lato + lato
	move $a0,$s0         #                       -se lato dispari: lato + lato -1
	syscall