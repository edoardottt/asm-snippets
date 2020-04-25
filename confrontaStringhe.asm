# DATE DUE STRINGHE, STAMPA LA MAGGIORE DELLE DUE.
.data
richiesta: .asciiz "inserire due stringhe di testo(max 100 caratteri)\n"
testo1: .space 101
testo2: .space 101
prima: .asciiz "la prima stringa è maggiore\n"
seconda: .asciiz "la seconda stringa è maggiore\n"
uguali: .asciiz "le due stringhe sono uguali\n"
.text
li $v0,4
la $a0,richiesta
syscall
li $v0,8
la $a0,testo1
li $a1,101
syscall
li $v0,8
la $a0,testo2
li $a1,101
syscall
scorri:
	lb $t2,testo1($t0)
	lb $t3,testo2($t1)
	seq $t8,$t2,10
	seq $t9,$t3,10
	beq $t8,1,vediSec
	beq $t9,1,secondaMinore
	beq $t2,$t3,successivo
	blt $t2,$t3,primaMinore
	bgt $t2,$t3,secondaMinore
vediSec:
	beq $t9,1,stampaUguali
	j primaMinore
stampaUguali:
	li $v0,4
	la $a0,uguali
	syscall
	li $v0,10
	syscall
secondaMinore:
	li $v0,4
	la $a0,prima
	syscall
	li $v0,10
	syscall
primaMinore:
	li $v0,4
	la $a0,seconda
	syscall
	li $v0,10
	syscall
successivo:
	addi $t0,$t0,1
	addi $t1,$t1,1
	j scorri