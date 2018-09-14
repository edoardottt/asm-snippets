# RICERCA BINARIA RICORSIVA IN UN VETTORE ORDINATO
.data
richiesta: .asciiz "inserire un numero intero positivo x da cercare nel vettore\n" 
vettore: .word 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,17,19,21,23,24,25,33,42,57,89,101,103,145,177,222,329,483,583,584,600
si: .asciiz "è presente"
no: .asciiz "non è presente"

.text
li $v0,4
la $a0,richiesta
syscall						# preparazione registri e syscall
li $v0,5
syscall
move $a1,$v0
la $a0,vettore
li $a2,0
li $a3,35
jal ricBin					# chiamata ricorsiva
j stampa					# salto a stampa

ricBin:
	subi $sp,$sp,12				# allocazione stack
	sw $ra,0($sp)
	sw $a2,4($sp)
	sw $a3,8($sp)
	
	bgt $a2,$a3,return0			# se i > j return 0
	sll $t3,$a2,2
	lw $t4,vettore($t3)			# v[i]
	sll $t5,$a3,2
	lw $t6,vettore($t5)			# v[j]
	slt $s0,$a1,$t4
	sgt $s1,$a1,$t6
	or $s2,$s0,$s1 				# if (x < v[i]) || (x> v[j])
	beq $s2,1,return0			# return 0
	add $t1,$a2,$a3
	div $t1,$t1,2				# m=(i+j)/2
	sll $t3,$t1,2
	lw $t2,vettore($t3)
	beq $t2,$a1,return1			# if v[m]==x return 1
	bgt $t2,$a1,ret1			#if v[m]>x
	addi $a2,$t1,1
	jal ricBin				# chiamata ricorsiva
	
	lw $ra,0($sp)				# disallocazione stack
	lw $a2,4($sp)
	lw $a3,8($sp)
	addi $sp,$sp,12
	jr $ra
return0:
	li $t0,0				
	lw $ra,0($sp)
	lw $a2,4($sp)
	lw $a3,8($sp)
	addi $sp,$sp,12
	jr $ra
return1:
	li $t0,1
	lw $ra,0($sp)
	lw $a2,4($sp)
	lw $a3,8($sp)
	addi $sp,$sp,12
	jr $ra
ret1:
	subi $a3,$t1,1
	jal ricBin				# chiamata ricorsiva
	lw $ra,0($sp)
	lw $a2,4($sp)
	lw $a3,8($sp)
	addi $sp,$sp,12
	jr $ra
stampa:
	beq $t0,1,stampaSi
	li $v0,4
	la $a0,no
	syscall
	li $v0,10
	syscall
stampaSi:
	li $v0,4
	la $a0,si
	syscall
	li $v0,10
	syscall








