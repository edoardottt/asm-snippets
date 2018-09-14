# VERIFICA SE UNA STRINGA è PALINDORMA CON LE SEGUENTI AGGIUNTIVE: I CARATTERI NON ALFA-NUMERICI VANNO IGNORATI, LE DUE LETTERE
#AGLI ESTREMI CORRISPONDONO SE E SOLO SE UNA è MAIUSCOLA E L'ALTRA MINUSCOLA.
.data
richiesta: .asciiz "inserire una stringa (max 100 caratteri)\n"
stringa: .space 101
len: .word 0
.text
li $v0,4
la $a0,richiesta
syscall
li $v0,8
la $a0,stringa
li $a1,100
syscall
lunghezza:
	lb $k0,stringa($k1)
	beq $k0,10,main
	addi $k1,$k1,1
	addi $s0,$s0,1
	j lunghezza
stampa:
	li $v0,1
	move $a0,$t9
	syscall
	li $v0,10
	syscall
main:
	li $t0,0
	subi $t1,$s0,1
	li $v0,'A'
	li $v1,'a'
	sub $v0,$v0,$v1
	abs $v0,$v0
	jal palindromo
	j stampa
palindromo:
	bgt $t0,$t1,JR
	lb $t4,stringa($t0)
	lb $t5,stringa($t1)
	bgt $t4,'z',prossimoSX
	blt $t4,'A',prossimoSX
	bgt $t5,'z',prossimoDX
	blt $t5,'A',prossimoDX
	sub $t6,$t4,$t5
	abs $t6,$t6
	beq $t6,$v0,prossimovalore
	beq $t6,0,controlla
	li $t9,0
	jr $ra
controlla:
	seq $t8,$t0,$t1
	bne $t8,1,jump
	li $t9,1
	jr $ra
jump:
	li $t9,0
	j palindromo
prossimoSX:
	addi $t0,$t0,1
	j palindromo
prossimoDX:
	subi $t1,$t1,1
	j palindromo
prossimovalore:
	li $t9,1
	addi $t0,$t0,1
	subi $t1,$t1,1
	j palindromo
JR:
	jr $ra