# CONTA QUANTI VALORI CON INDICI PARI CI SONO NELLA LISTA
.data
richiesta: .asciiz "inserire la lunghezza del vettore ed inserire i valori(max 20)\n"
vettore: .space 21
N: .word 0
.text
li $v0,4
la $a0,richiesta
syscall
li $v0,5
syscall
sw $v0,N
move $t0,$v0
addi $t9,$t9,1
riempi:
	li $v0,5
	syscall
	beq $t9,$t0,main
	sw $v0,vettore($s0)
	addi $t9,$t9,1
	addi $s0,$s0,4
	j riempi
main:
	li $t1,0
	jal contaPari
	li $v0,1
	move $a0,$s1
	syscall
	li $v0,10
	syscall
contaPari:
	lw $t2,vettore($t1)
	beq $t2,-1,JR
	div $t1,$t1,4
	div $t3,$t1,2
	mfhi $t3
	beq $t3,0,pari
	sll $t1,$t2,2
	j contaPari
pari:
	addi $s1,$s1,1
	sll $t1,$t2,2
	j contaPari
JR:
	jr $ra
	