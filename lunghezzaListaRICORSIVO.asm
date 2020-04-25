# DATA UNA STRUCT LISTA STAMPARE RICORSIVAMENTE LE VISITE E INFINE LA SUA LUNGHEZZA
.data
richiesta: .asciiz "inserire il numero dei valori e successivamente la lista(max 100 valori)\n"
lista: .word 0:100
N: .word 0
.text
li $v0,4
la $a0,richiesta
syscall
li $v0,5
syscall
sw $v0,N
move $t0,$v0
li $a0,0
riempi:
	beq $t1,$t0,main
	li $v0,5
	syscall
	sw $v0,lista($a0)
	addi $a0,$a0,4
	addi $t1,$t1,1
	j riempi
main:
	li $s0,0
	jal LEN
	li $v0,11
	li $a0,'\n'
	syscall
	li $v0,1
	move $a0,$s3
	syscall
	li $v0,10
	syscall
	
LEN:
	subi $sp,$sp,8
	sw $ra,0($sp)
	sw $s0,4($sp)
	
	sll $s1,$s0,2
	lw $s2,lista($s1)
	li $v0,1
	move $a0,$s0
	syscall
	li $v0,11
	li $a0,'\r'
	syscall
	addi $s3,$s3,1
	beq $s2,-1,casoBase
	move $s0,$s2
	jal LEN
	
	lw $ra,0($sp)
	lw $s0,4($sp)
	addi $sp,$sp,8
	jr $ra
casoBase:
	lw $ra,0($sp)
	lw $s0,4($sp)
	addi $sp,$sp,8
	jr $ra
