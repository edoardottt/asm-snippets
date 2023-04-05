# CONTA OCCORRENZE DI X IN UN VETTORE RICORSIVAMENTE
.data
richiesta: .asciiz " inserire un numero da cercare nel vettore\n"
vettore: .word 1,2,2,3,3,3,4,4,4,4,5,5,5,5,5,6,6,6,6,6,6,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,9
elem: .word 45
.text
li $v0,4
la $a0,richiesta
syscall
li $v0,5
syscall
move $a0,$v0
li $t1,45					# j (indice fine)
jal conta					# chiamata ricorsiva
stampa:
li $v0,1
move $a0,$t5
syscall
li $v0,10
syscall

conta:
	subi $sp,$sp,12				#allocazione stack
	sw $ra,0($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	
	beq $t1,$t0,caso_base			# caso base
	subi $t1,$t1,1				# aggiornamento parametri
	jal conta				# chiamata ricorsiva
	sll $t3,$t1,2				# offset
	lw $t4,vettore($t3)			# elemento corrente
	beq $t4,$a0,aggiornaCont		# occorrenze++
	lw $ra,0($sp)				# ripristino stack
	lw $t0,4($sp)
	lw $t1,8($sp)
	addi $sp,$sp,12
	jr $ra
	
caso_base:
	lw $ra,0($sp)				# ripristino stack
	lw $t0,4($sp)
	lw $t1,8($sp)
	addi $sp,$sp,12
	jr $ra
aggiornaCont:
	addi $t5,$t5,1			
	lw $ra,0($sp)				
	lw $t0,4($sp)
	lw $t1,8($sp)
	addi $sp,$sp,12
	jr $ra
 