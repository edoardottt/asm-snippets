# IN INPUT LUNGHEZZA DEL VETTORE, VETTORE ORDINATO ED ELEMENTO DA CERCARE
#RICORSIVAMENTE CERCA IL VALORE E STAMPA I VALORI ESAMINATI
.data
richiesta: .asciiz "inserire la lunghezza del vettore,poi i valori in ordine crescente ed infine l' elemento da cercare\n"
vettore: .word 0:100
N: .word 0
si: .asciiz "è presente con indice "
no: .asciiz "non è presente "
.text
li $v0,4
la $a0,richiesta
syscall
li $v0,5
syscall
sw $v0,N
lw $t0,N
riempi:
	beq $t1,$t0,elemento
	li $v0,5
	syscall
	sll $t2,$t1,2
	sw $v0,vettore($t2)
	addi $t1,$t1,1
	j riempi
elemento:
	li $v0,5
	syscall
	move $s0,$v0
main:
	li $t1,0
	jal RICBIN
RICBIN:	
	subi $sp,$sp,12
	sw $ra,0($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	
	beq $t0,0,NO
	div $t2,$t0,2
	add $t6,$t1,$t2
	sll $t3,$t6,2
	lw $t4,vettore($t3)
	li $v0,1
	move $a0,$t6
	syscall
	li $v0,11
	li $a0,'\t'
	syscall
	beq $t4,$s0,trovato
	jal verifica
	jal RICBIN
	lw $ra,0($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	addi $sp,$sp,12
	jr $ra
verifica:
	blt $t4,$s0,minore
	div $t0,$t0,2
	jr $ra
	minore:
		addi $t1,$t6,1
		addi $t2,$t2,1
		sub $t0,$t0,$t2
		jr $ra
trovato:
	li $v0,4
	la $a0,si
	syscall
	li $v0,1
	move $a0,$t6
	syscall
	li $v0,10
	syscall
NO:
	li $v0,4
	la $a0,no
	syscall
	li $v0,10
	syscall
	