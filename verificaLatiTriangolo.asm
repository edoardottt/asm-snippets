# DATI TRE LATI IN INPUT, STAMPA SE IL TRIANGOLO è IDONEO O NO
.data
lato1: .word 0
lato2: .word 0
lato3: .word 0
esito: .asciiz "idoneo"
esito2: .asciiz "non idoneo"
richiesta: .asciiz "inserire tre valori interi\n"

.text
li $v0,4
la $a0,richiesta
syscall
inserimento:
	li $v0,5
	syscall
	sw $v0,lato1
	li $v0,5
	syscall
	sw $v0,lato2
	li $v0,5
	syscall
	sw $v0,lato3
	lw $s1,lato1
	lw $s2,lato2
	lw $s3,lato3
confrontaPrimo:
	add $t1,$s1,$s2
	bgt $t1,$s3,confrontaSecondo
	j nonIdoneo
confrontaSecondo:
	add $t2,$s1,$s3
	bgt $t2,$s2,confrontaTerzo
	j nonIdoneo
confrontaTerzo:
	add $t3,$s2,$s3
	bgt $t3,$s1,Idoneo
Idoneo:
	li $v0,4
	la $a0,esito
	syscall
	li $v0,10
	syscall
nonIdoneo:
	li $v0,4
	la $a0,esito2
	syscall




