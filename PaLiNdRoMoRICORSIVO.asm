# VERIFICA SE UNA STRINGA è PALINDORMA RICORSIVAMENTE CON LE SEGUENTI AGGIUNTIVE: I CARATTERI NON ALFA-NUMERICI VANNO IGNORATI, LE DUE
#LETTERE AGLI ESTREMI CORRISPONDONO SE E SOLO SE UNA è MAIUSCOLA E L'ALTRA MINUSCOLA .
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
	subi $sp,$sp,12
	sw $ra,0($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	
	bge $t0,$t1,casobase
	jal verifica
	sub $t6,$t4,$t5
	abs $t6,$t6
	seq $t9,$t6,$v0
	seq $t8,$t0,$t1
	jal valorecentrale
	addi $t0,$t0,1
	subi $t1,$t1,1
	jal palindromo
	lw $ra,0($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	addi $sp,$sp,12
	jr $ra
valorecentrale:
	beq $t8,1,Jr
	jr $ra
	Jr:
	li $t9,1
	jr $ra
verifica:
	lb $t4,stringa($t0)
	lb $t5,stringa($t1)
	bgt $t4,'z',prossimoSX
	blt $t4,'A',prossimoSX
	bgt $t5,'z',prossimoDX
	blt $t5,'A',prossimoDX
	jr $ra
prossimoSX:
	addi $t0,$t0,1
	lb $t4,stringa($t0)
	jr $ra
prossimoDX:
	subi $t1,$t1,1
	lb $t5,stringa($t1)
	jr $ra
casobase:
	lw $ra,0($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	addi $sp,$sp,12
	jr $ra