# DATA UNA LISTA STRUTTURATA COME COPPIE <VALORE,NEXT> SALVARE IN UN VETTORE E STAMPARE IL RISULTATO DELLA VISITA DI ESSA.
.data 
lista: .word 1,1,2,3,3,5,4,2,5,-1,6,4
visita: .word 0:6
.text
li $t0,0
li $t6,0
li $t7,0
scorri:
	ble $t5,-1,stampa
	sll $t1,$t0,2
	lw $t2,lista($t1)
	sw $t2,visita($t6)
	addi $t6,$t6,4
	addi $t3,$t0,1
	sll $t4,$t3,2
	lw $t5,lista($t4)
	mul $t5,$t5,2
	move $t0,$t5
	j scorri
stampa:
	beq $t7,24,fine
	lw $t8,visita($t7)
	addi $t7,$t7,4
	li $v0,1
	move $a0,$t8
	syscall
	j stampa
fine:
	li $v0,10
	syscall