# BUBBLE SORT
.data
richiesta: .asciiz "inserire la lunghezza del vettore,poi i valori numerici\n"
vettore: .word 0:100
len: .word 0
.text
li $v0,4
la $a0,richiesta
syscall
li $v0,5
syscall
sw $v0,len
lw $s1,len
li $a0,0
riempi:
	beq $s0,$s1,main
	li $v0,5
	syscall
	sw $v0,vettore($a0)
	addi $a0,$a0,4
	addi $s0,$s0,1
	j riempi
main:
	subi $s2,$s1,1	
	jal bubblesort
	stampa:
		bge $a3,$s1,fine
		lw $a2,vettore($a1)
		li $v0,1
		move $a0,$a2
		syscall
		addi $a1,$a1,4
		addi $a3,$a3,1
		li $v0,11
		li $a0,' '
		syscall
		j stampa
		fine:
			li $v0,10
			syscall
	
bubblesort:
	beq $t0,$s1,JR
	for:
		beq $t2,$s2,endFor
		sll $t3,$t2,2
		addi $t4,$t2,1
		sll $t5,$t4,2
		lw $t6,vettore($t3)
		lw $t7,vettore($t5)
		bgt $t6,$t7,cambio
		addi $t2,$t2,1
		j for
		cambio:
			move $t8,$t6
			sw $t7,vettore($t3)
			sw $t8,vettore($t5)
			addi $t2,$t2,1
			j for
	endFor:
		li $t2,0
		addi $t0,$t0,1
		j bubblesort
JR:
	jr $ra
		