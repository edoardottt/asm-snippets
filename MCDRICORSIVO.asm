# MCD TRA DUE INTERI POSITIVI RICORSIVO
.data
richiesta: .asciiz "inserire due valori x ed y interi positivi\n"

.text
li $v0,4
la $a0,richiesta
syscall

li $v0,5
syscall
move $s0,$v0      #X
li $v0,5
syscall
move $s1,$v0      #Y
jal mcd
li $v0,1
syscall
li $v0,10
syscall
mcd:
	subi $sp,$sp,12
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	
	beq $s0,$s1,caso_base
	jal verifica
	jal mcd
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	addi $sp,$sp,12
	jr $ra
caso_base:
	move $a0,$s0
	
	lw $ra,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	addi $sp,$sp,12
	jr $ra
verifica:
	sgt $t0,$s0,$s1
	beq $t0,1,cambia
	sub $s1,$s1,$s0
	jr $ra
cambia:
		move $s2,$s1
		move $s1,$s0
		move $s0,$s2
		jr $ra
	
	
	
	
	
	
	
	
	