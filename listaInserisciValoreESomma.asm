#è COSTRUITO UN VETTORE CON COPPIE DI INTERI <VALORE,NEXT> IN CUI NEXT è L'INDICE DEL PROSSIMO VALORE
#SI COSTRUISCA UN ALGORITMO INSERISCI_VALORE_E_SOMMA CHE INSERISCA NELLA LISTA IL VALORE CON IL GIUSTO INDICE
#E STAMPI LA SOMMA DI TUTTI I VALORI PRESENTI NELLA LISTA
.data
vettore: .word 0:100
.text
li $t1,0
li $t3,1
la $t5,vettore
li $s0,0
li $s2,1
input:
	li $v0,5
	syscall
	move $t0,$v0
	beq $t0,-1,fine
	jal ives
	j input
ives:	
	sll $t2,$t1,2
	sw $t0,vettore($t2)
	sll $t4,$t3,2
	addi $t6,$t3,1
	sw $t6,vettore($t4)
	addi $t1,$t1,2
	addi $t3,$t3,2
	jal calcola
	j input
	
calcola:
	somma:
	beq $s0,$t1,jRegister
	lw $s1,vettore($s4)
	add $s3,$s3,$s1
	addi $s4,$s4,4
	lw $s5,vettore($s4)
	sll $s4,$s5,2
	addi $s0,$s0,2
	j somma
	
jRegister:
	li $v0,1
	move $a0,$s3
	syscall
	jr $ra
fine:
	li $v0,10
	syscall
	
	