# INSERTION SORT 
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
	li $t0,1
	jal insertionSort
	stampa:
		bge $a3,$s1,fine
		lw $a2,vettore($a1)
		li $v0,1
		move $a0,$a2
		syscall
		addi $a1,$a1,4
		addi $a3,$a3,1
		j stampa
		fine:
			li $v0,10
			syscall

insertionSort:
	beq $t0,$s1,JR
	sll $t3,$t0,2
	lw $t2,vettore($t3)
	move $t4,$t2
	subi $t1,$t0,1
	while:
		slt $s6,$t1,$k0
		sll $t5,$t1,2
		lw $s5,vettore($t5)
		sle $s7,$s5,$t4
		or $s4,$s6,$s7
		beq $s4,1,exit
		addi $t9,$t1,1
		sll $t9,$t9,2
		sw $s5,vettore($t9)
		subi $t1,$t1,1
		addi $t8,$t1,1
		sll $t8,$t8,2
		sw $t4,vettore($t8)
		j while
	exit:
	addi $t0,$t0,1
	j insertionSort
JR:
	jr $ra
