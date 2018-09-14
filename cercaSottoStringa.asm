# CERCA SOTTOSTRINGA N UNA STRINGA E STAMPA L'INDICE DOVE SI TROVA, -1 SE NON è PRESENTE.
.data
richiesta: .asciiz "inserire due stringhe, controlla se la seconda è presente nella prima\n"
stringa: .space 101 
sottostringa: .space 101
.text
li $v0,4
la $a0,richiesta
syscall
li $v0,8
la $a0,stringa
li $a1,101
syscall
li $v0,8
la $a0,sottostringa
li $a1,101
syscall
main:
	li $s0,0
	li $s1,0
	jal cerca
	li $v0,1
	move $a0,$k0
	syscall
	li $v0,10
	syscall
cerca:
	lb $s2,stringa($s0)
	lb $s3,sottostringa($s1)
	beq $s2,10,JR
	beq $s3,10,SI
	beq $s2,$s3,M
	li $s1,0
	li $k0,0
	li $s1,0
	addi $s0,$s0,1
	j cerca
M:
	beq $s6,0,INIZIO
	addi $s1,$s1,1
	addi $s0,$s0,1
	j cerca
	INIZIO:
	li $s6,1
	move $k0,$s0
	addi $s1,$s1,1
	addi $s0,$s0,1
	j cerca
JR:
	li $k0,-1
	jr $ra
SI:
	jr $ra