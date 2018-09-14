# INSERTION SORT RICORSIVO
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
addi $s1,$s1,1
	li $k0,0
	jal insertionSort
	subi $s1,$s1,1
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
	subi $sp,$sp,8
	sw $ra,0($sp)
	sw $s1,4($sp)
	
	ble $s1,2,casobase
	subi $s1,$s1,1
	jal insertionSort
	subi $s2,$s1,1
	sll $k1,$s2,2
	lw $s3,vettore($k1)
	move $s4,$s3
	subi $t0,$s2,1
	jal while
	
	lw $ra,0($sp)
	lw $s1,4($sp)
	addi $sp,$sp,8
	jr $ra
	while:
		slt $s5,$t0,$k0
		sll $t9,$t0,2
		lw $s6,vettore($t9)
		sle $s7,$s6,$s4
		or $s7,$s5,$s7
		beq $s7,1,endWhile
		addi $t7,$t0,1
		sll $t7,$t7,2
		sw $s6,vettore($t7)
		subi $t0,$t0,1
		addi $t5,$t0,1
		sll $t5,$t5,2
		sw $s4,vettore($t5)
		j while
endWhile:
	jr $ra
casobase:
	lw $ra,0($sp)
	lw $s1,4($sp)
	addi $sp,$sp,8
	jr $ra
		
