# SOMMA NUMERI IN VETTORE CON INDICI DIVISIBILI PER 3

# CON PUNTATORI

.data
vettore: .word 0,1,2,3,4,5,6,7,8,9
N: .word 10

.text 

main: 
	la $t0,vettore      # indirizzo vettore
	lw $t2,N          
	sll $t3,$t2,2       # ultimo indice vettore (byte)
	add $t1,$t0,$t3
loop:
	bgt $t0,$t1,fine   
	lw $t5,($t0)        # elemento corrente
	add $t6,$t6,$t5     # aggiornamento somma
	addi $t0,$t0,12     # aggiornamento indice ( +12 byte = elementi con indici divisibili per 3)
	j loop
fine: 
	li $v0,1
	move $a0,$t6
	syscall            # (18=0+3+6+9)