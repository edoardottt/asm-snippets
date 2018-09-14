# TROVARE VALORE MODA IN UN VETTORE CON UNA SOLA FREQUENZA MASSIMA RICORSIVAMENTE
.data
vettore: .word 0,1,4,4,7,7,7,4,4,4,3,3,8,7,7,7
nElem: .word 16
.text
li $t1,0
li $t2,0
lw $t7,nElem
scorri:
	bge $t2,$t7,fine			#se i>= 17 esci
	li $t8,0				# azzero occorrenza elem. corrente
	li $s0,0				# azzero indice i
	li $s1,15				# ricarico indice j (fine)
	sll $t4,$t2,2				# offset elem.corrente
	lw $t5,vettore($t4)			# elem. corrente
	beq $t5,$t0,saltaElem			# se elem.da esaminare==max salto al prossimo valore
	jal conta				# chiamata ricorsiva
	bge $t8,$v0,aggiorna			# se frequenza elem. corrente >= frequenza max aggiorno max
	addi $t2,$t2,1				# altrimenti aggiorno comunque l'indice
	j scorri				# nuova iterazione su nuovo indice
	conta:
		subi $sp,$sp,12			# allocazione stack
		sw $ra,0($sp)
		sw $s0,4($sp)
		sw $s1,8($sp)
		
		ble $s1,$s0,caso_Base      	# se i<=j sto nel caso base
		subi $s1,$s1,1			# j--
		jal conta			# chiamata ricorsiva
		sll $s2,$s1,2			# offset elem. corrente ( da non confondere..questo è quello corrente da esaminare)
		lw $s3,vettore($s2)		# elem. corrente
		beq $s3,$t5,occo		# se elem.corrente==elemento da esaminare salto a aggiorna occorrenza
		
		lw $ra,0($sp)			# ripristino stack
		lw $s0,4($sp)
		lw $s1,8($sp)
		addi $sp,$sp,12
		jr $ra	
saltaElem:
	addi $t2,$t2,1
	j scorri
occo:
	addi $t8,$t8,1				# aggiornamento occorrenza
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	addi $sp,$sp,12
	jr $ra	
aggiorna:
	move $v0,$t8				# salvo la frequenza del valore max
	move $t0,$t5				# salvo valore max
	addi $t2,$t2,1
	j scorri
caso_Base:
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	addi $sp,$sp,12
	jr $ra
fine:
	li $v0,1
	move $a0,$t0
	syscall
	li $v0,10
	syscall
	
	
