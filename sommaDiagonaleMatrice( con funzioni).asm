# SOMMA DIAGONALI MATRICE ( CON FUNZIONI ) 
# ATTENZIONE AL CARATTERE CENTRALE
.data
matrice: .word 49:1
x: .word 7
y: .word 7
lato: .word 7

.text
main:
	lw $t1,x
	lw $t2,y
	mul $t3,$t1,$t2
	sll $t3,$t3,2
	li $t1,1
	li $a0,0
	li $a1,0
	lw $t4,lato				#preparazione variabili d'appoggio
riempiValori:
	bge $t0,$t3,cicloX
	sw $t1,matrice($t0)			#riempimento valori nella matrice
	addi $t0,$t0,4
	j riempiValori
cicloX:
	bgt $a1,$t4,stampa
	bgt $a0,$t4,nextY                       #scorro tutta la rgia se è finita aggiorno y e azzero x
	jal is_diagonal
	beq $v0,1,aggiungi
	addi $a0,$a0,1
	j cicloX
	aggiungi:
		jal leggi_elemento             #aggiorno somma e aggiorno x
		add $s0,$s0,$v0
		addi $a0,$a0,1
		j cicloX
	nextY:
		li $a0,0                      # se finita la riga incremento y
		addi $a1,$a1,1
		j cicloX
	is_diagonal:
		beq $a0,$a1,yes               # verifica se si trova sulla diagonale
		add $v0,$a0,$a1
		addi $v0,$v0,1
		beq  $v0,$t4,yes
		li $v0,0
		jr $ra
		yes:
			li $v0,1
			jr $ra
	leggi_elemento:
		mul $v0,$a1,$a0               # lettura elemento in diagonale
		add $v0,$v0,$a0
		sll $v0,$v0,2
		lw $v0,matrice($v0)
		jr $ra
		stampa:                       # matrice di lato sette: risultato= 7+7-1=13
			li $v0,1
			move $a0,$s0
			syscall
	
	
	