# FUNZIONA MA NON STAMPA è PALINDROMA
.data
richiesta: .asciiz "inserire una stringa(max 100 caratteri)"
stringa: .asciiz 
true: .asciiz "è palindroma"
false: .asciiz "non è palindroma"

.text
li $v0,4
la $a0,richiesta
syscall

input:
	li $v0,8
	la $a0,stringa
	li $a1,101
	syscall
	la $t0,stringa
lunghezza:
	lb $s0,0($t0)
	beq $s0,'\n',preparazione
	addi $t0,$t0,1
	addi $t1,$t1,1
	j lunghezza
preparazione:
	subi $t3,$t1,1
	la $t0,stringa
	la $t2,stringa
	add $t2,$t2,$t3
	li $t4,0
	scorri:
		bge $t4,$t3,p
		lb $s0,0($t0)
		lb $s1,0($t2)
		jal verifica
		beq $s2,1,avanti
		j np
avanti:
	addi $t0,$t0,1
	subi $t2,$t2,1
	addi $t4,$t4,1
	subi $t3,$t3,1
	j scorri
verifica:
	seq $s2,$s0,$s1
	jr $ra
np:
	la $a0,false
	j stampa
p:
	la $a0,true
	j stampa
stampa:
	li $v0,4
	syscall
	li $v0,10
	syscall