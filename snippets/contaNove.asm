.data
vettore: .word 2,2,3,4,3,1,2,1,2,1,2		
n: .word 11				#dim
x: .word 2				#elemento da contare

.text
.globl main
main:
	#preparo funzione
	la $a0, vettore
	lw $a1, n
	lw $a2, x
	li $a3, 0
	
	jal contaX
	
	#stampa
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
#input
#v0 deve essere 0 al momento della chiamata
#$a0 vettore
#$a1 dim vettore
#$a2 elemento da contare
#a3 indice
#NOTA a3 sarà == dim alla fine
#output
#$v0 numero occerrenze di x nel vettore

#psuedo
#$v0 contatore - globale
#contaX(v, n, x, i)
#if i>=n return
#if v[i]==x
#	conta++
#return contaX(v, n, x, i+1)
contaX:
	bge $a3, $a1, fine
	#salvo valori nello stack
	sub $sp, $sp, 8
	sw $ra, 0($sp) 
	sw $a3, 4($sp)
	
	mul $t0, $a3, 4		#offset nel vettore
	add $t0, $t0, $a0	#indirizzo elemento i-esimo
	lw $t0, 0($t0)		#carico elemento
	bne $t0, $a2, ret	#if v[i]!=x -> chiamata senza incr
	#se è uguale
	add $v0, $v0, 1		#conta++
	
	ret:
	add $a3, $a3, 1		#indice++
	#chiamata ricorsiva
	jal contaX
	
	#carico valori dallo stack
	lw $ra, 0($sp)
	lw $a3, 4($sp)
	add $sp, $sp, 8
	
	fine:
	jr $ra