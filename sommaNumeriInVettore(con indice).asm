# SOMMA NEGLI INDICI DIVISIBILI PER 3 IN UN VETTORE

# CON INDICE

.data 
label: .word   0,1,2,3,4,5,6,7,8,9
N: .word 10

.text
main:
	lw $t1,N         # fine vettore
	li $t0,0         # indice
	li $t2,0         # somma
loop:
	bgt $t0,$t1,fine
	sll $t3,$t0,2    # indice puntato all'elemento
	lw $t4,label($t3) # elemento
	add $t2,$t2,$t4   # aggiornamento somma
	addi $t0,$t0,3
	j loop		
fine:
	li $v0,1
	move $a0,$t2
	syscall         #(18=9+6+3+0)
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	