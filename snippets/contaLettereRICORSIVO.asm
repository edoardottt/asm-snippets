# CONTA I CARATTERI DI UNA STRINGA DATA IN INPUT RICORSIVAMENTE E STAMPA LA TERNA <#LETTERE,#NUMERI,#ALTRO>
.data
richiesta: .asciiz "inserire una stringa (max 100 caratteri)\n"
stringa: .space 101
.text
li $v0,4
la $a0,richiesta
syscall
li $v0,8
la $a0,stringa
li $a1,100
syscall
len:
	lb $s0,stringa($s1)
	beq $s0,10,main
	addi $s2,$s2,1
	addi $s1,$s1,1
	j len
main:
	li $a1,0
	subi $s2,$s2,1
	li $t0,0
	jal conta
	li $v0,1
	move $a0,$a1
	syscall
	li $v0,11
	li $a0,'\t'
	syscall
	li $v0,1
	move $a0,$a2
	syscall
	li $v0,11
	li $a0,'\t'
	syscall
	li $v0,1
	move $a0,$a3
	syscall
	li $v0,11
	li $a0,'\t'
	syscall
	li $v0,10
	syscall
conta:
	subi $sp,$sp,8
	sw $ra,0($sp)
	sw $t0,4($sp)
	
	bgt $t0,$s2,casobase
	lb $t1,stringa($t0)
	#controllo lettera
	sle $s3,$t1,'z' 
	sge $s4,$t1,'a'
	and $s5,$s3,$s4
	sle $s3,$t1,'Z' 
	sge $s4,$t1,'A'
	and $s6,$s3,$s4
	or $s6,$s5,$s6
	# controllo numeri
	sge $s3,$t1,'0'
	sle $s4,$t1,'9'
	and $s7,$s3,$s4
	jal verifica
	addi $t0,$t0,1
	jal conta
	
	lw $ra,0($sp)
	lw $t0,4($sp)
	addi $sp,$sp,8
	jr $ra
verifica:
	beq $s6,1,lettere
	beq $s7,1,numeri
	addi $a3,$a3,1
	jr $ra
	numeri:
	addi $a2,$a2,1
	jr $ra
	lettere:
	addi $a1,$a1,1
	jr $ra
casobase:
	lw $ra,0($sp)
	lw $t0,4($sp)
	addi $sp,$sp,8
	jr $ra