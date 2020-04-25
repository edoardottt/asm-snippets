# STAMPA INVERSA DI UNA STRUCT LISTA
.data
lista: .word
	4,4,
	2,-1,
	1,3,
	3,1,
	5,2
.text
li $t0,0
li $t1,0
jal PR					# chiamata ricorsiva
li $v0,10
syscall

PR:
	subi $sp,$sp,12			# allocazione stack
	sw $ra,0($sp)
	sw $t0,4($sp)
	sw $t4,8($sp)
	
	addi $t1,$t0,1			# i++
	sll $t2,$t0,2			# offset i
	sll $t3,$t1,2			# offset i++
	lw $t4,lista($t2)		# elemento i
	lw $t5,lista($t3)		# elemento i++(prossimo indice)
	beq $t5,-1,casobase		#se i++==-1 lista finita
	mul $t0,$t5,2			# i++*2
	jal PR				# chiamata ricorsiva
	li $v0,1			# stampa alla chiusura delle chiamate ricorsive
	move $a0,$t4
	syscall
	li $v0,11			# stampa tab
	li $a0,'\t'
	syscall
	lw $ra,0($sp)
	lw $t0,4($sp)			# ripristino stack
	lw $t4,8($sp)
	addi $sp,$sp,12
	jr $ra
casobase:				# caso base
	li $v0,1
	move $a0,$t4
	syscall
	li $v0,11
	li $a0,'\t'
	syscall
	lw $ra,0($sp)
	lw $t0,4($sp)
	lw $t4,8($sp)
	addi $sp,$sp,12
	jr $ra
	