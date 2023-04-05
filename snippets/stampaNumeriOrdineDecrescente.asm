.data
richiesta: .asciiz "inserire valori (3) \n"
vettore: .space 3
primo: .word 0
secondo: .word 0
terzo: .word 0
acapo: .asciiz "\n"
.text
la $t1,acapo
la $t0,richiesta
input:	
	li $v0,4			# richiesta inserimento input
	move $a0,$t0
	syscall
inserisci:
	li $v0,5
	syscall
	move $s0,$v0
	li $v0,5
	syscall
	move $s1,$v0
	li $v0,5
	syscall
	move $s2,$v0
confronta:
	bge $s0,$s1,seconfronto
	bge $s1,$s2,terconfronto
	sw $s2,primo
	sw $s1,secondo
	sw $s0,terzo
	j fine
terconfronto:
	sw $s1,primo
	bge $s0,$s2,quaconfronto
	sw $s2,secondo
	sw $s0,terzo
	j fine
quaconfronto:
	sw $s0,secondo
	sw $s2,terzo
	j fine
seconfronto:
	bge $s0,$s2,s0primo
	sw $s2,primo
	sw $s0,secondo
	sw $s1,terzo
	j fine
s0primo:
	sw $s0,primo
	bge $s1,$s2,secondoC
	sw $s2,secondo
	sw $s1,terzo
	j fine
secondoC:
	sw $s1,secondo
	sw $s2,terzo
	j fine
fine:
	lw $t3,primo
	lw $t4,secondo
	lw $t5,terzo
	li $v0,1
	move $a0,$t3
	syscall
	li $v0,4
	move $a0,$t1
	syscall
	li $v0,1
	move $a0,$t4
	syscall
	li $v0,4
	move $a0,$t1
	syscall
	li $v0,1
	move $a0,$t5
	syscall
	li $v0,4
	move $a0,$t1
	syscall