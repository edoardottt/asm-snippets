# ACQUISIZIONE E SOMMA DI VALORI INTERI PRESI IN INPUT SALVATI IN UN VETTORE

.data
vettore: .space 100
richiesta: .asciiz "inserire al max 100 valori (0 per terminare)\n"

.text:
la $t0,vettore				# preparo registri
li $v0,4
la $a0,richiesta
syscall
input:
	li $v0,5			# finche non trovo lo zero, salvo input
	syscall
	beqz $v0,calcolaSomma
	sw $v0,0($t0)
	addi $t0,$t0,4
	addi $t1,$t1,1
	j input
calcolaSomma:
	la $t0,vettore
	li $t2,0
	scorri:				# sommo tutti i valori scorrendo il vettore
		bge $t2,$t1,stampaSomma
		lw $t3,0($t0)
		add $s0,$s0,$t3
		addi $t2,$t2,1
		addi $t0,$t0,4
		j scorri
stampaSomma:                            # arrivato alla fine del vettore, stampo
	li $v0,1
	move $a0,$s0
	syscall
		