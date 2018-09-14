#SELECTION SORT
.data
richiesta: .asciiz "inserire la lunghezza del vettore e poi i valori(max 100)\n"
vettore: .word 0:100
len: .word 0
.text
li $v0,4
la $a0,richiesta
syscall
li $v0,5
syscall
sw $v0,len
move $s0,$v0
li $a0,0
riempi:
	beq $s1,$s0,main
	li $v0,5
	syscall
	sw $v0,vettore($a0)
	addi $s1,$s1,1
	addi $a0,$a0,4
	j riempi
main:
	li $t0,0
	subi $s2,$s0,1
	jal selectionSort
	stampa:
		beq $k0,$s0,fine
		sll $a3,$k0,2
		lw $k1,vettore($a3)
		li $v0,1
		move $a0,$k1
		syscall
		addi $k0,$k0,1
		li $v0,11
		li $a0,' '
		syscall
		j stampa
		fine:
			li $v0,10
			syscall

selectionSort:
	bge $t0,$s2,JR
	move $t1,$t0
	addi $t2,$t0,1
	for:
	bge $t2,$s0,esci
	sll $t4,$t2,2
	lw $t3,vettore($t4)
	sll $t6,$t1,2
	lw $t5,vettore($t6)
		blt $t3,$t5,cambio
		addi $t2,$t2,1
		j for
		cambio:
		move $t1,$t2
		addi $t2,$t2,1
		j for
esci:
	bne $t1,$t0,cambia
	addi $t0,$t0,1
	j selectionSort
	cambia:
	sll $s3,$t0,2
	lw $s4,vettore($s3)
	move $s5,$s4
	sll $s6,$t1,2
	lw $s7,vettore($s6)
	sw $s7,vettore($s3)
	sw $s5,vettore($s6)
	addi $t0,$t0,1
	j selectionSort
JR:
	jr $ra
	