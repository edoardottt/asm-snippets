# CALCOLO DI UNA MATRICE CONTENENTE I CUBI (x^3) DI INTERI DI UN'ALTRA MATRICE
.data
matrice: .word  1,2,3,4,5
		5,4,3,2,1
		6,7,8,9,0
righe: .word 3
colonne: .word 5
matriceCubi: .word 0:15
a_capo: .asciiz "\r\n"
space: .byte 32
.text
la $a0,matrice
li $a1,0
lw $t0,righe
lw $t1,colonne
mul $a2,$t0,$t1
la $s0,matriceCubi
ciclo:
	beq $a1,$a2,stampaP
	lw $a3,0($a0)
	mul $s5,$a3,$a3
	mul $a3,$a3,$s5
	sw $a3,0($s0)
	addi $s0,$s0,4
	addi $a0,$a0,4
	addi $a1,$a1,1
	j ciclo
stampaP:
	li $t6,0
	li $t2,0
	la $s0,matriceCubi
	la $a3,space
	stampa:
		beq $t2,15,esci
		lw $t3,0($s0)
		li $v0,1
		move $a0,$t3
		syscall
		li $v0,4
		move $a0,$a3
		syscall
		addi $s0,$s0,4
		addi $t2,$t2,1
		addi $t6,$t6,1
		beq $t6,5,nextLine
		beq $t6,10,nextLine
		j stampa
nextLine:
		li $v0,4
		la $a0,a_capo
		syscall
		j stampa
esci:
	li $v0,10
	syscall