 # SOMMA PER COLONNE DI UNA MATRICE NxM ( QUALSIASI COLONNA SI SCEGLIE RISUKTA SEMPRE LO STESSO RISULTATO)
 .data
matrice: .word 91:1
richiesta: .asciiz "inserire un 0<n<12 tale che sia effettuata la somma della n-esima colonna"
richiesta2: .asciiz "inserire un valore per inizializzare i valori"
n: .word 13
m: .word 7
.text
li $v0,4
la $a0,richiesta
syscall
li $v0,5
syscall
move $s2,$v0
li $v0,4
la $a0,richiesta2
syscall
li $v0,5
syscall
move $s3,$v0
lw $s0,n
lw $s1,m
#preparazione
la $a0,matrice
riempi:
	beq $t1,91,prep
	sw $s3,0($a0)
	addi $a0,$a0,4
	addi $t1,$t1,1
	j riempi
prep:
	la $a0,matrice
	sll $s2,$s2,2
	li $s4,13
	sll $s4,$s4,2
	mul $s5,$s4,7
	add $a1,$a0,$s5
	add $a0,$a0,$s2
loop:
	bge $a0,$a1,stampa
	lw $t3,0($a0)
	add $s7,$s7,$t3
	add $a0,$a0,$s4
	j loop
stampa:
	li $v0,1
	move $a0,$s7
	syscall
	li $v0,10
	syscall
	
	
 
