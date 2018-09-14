# STAMPARE UN VETTORE IN INPUT AL CONTRARIO RICORSIVAMENTE SENZA VETTORE DI APPOGGIO
# DA TROVARE ERRORE: LE CHIAMATE RICORSIVE SONO GIUSTE, MA ESCE PRIMA DI CHIUDERE L'ULTIMA
# ESEMPIO: VETTORE= 1,2,3,4,5===STAMPA====> 1,4,3,2,5
.data
vettore: .word 50:1
richiesta: .asciiz "inserire interi positivi da salvare sul vettore (max 100), -1 per terminare\n"
vettVuoto: .asciiz "vettore vuoto\n"
space: .byte 32

.text
li $t8,-1
li $v0,4
la $a0,richiesta
syscall
la $a0,vettore
addi $s7,$a0,200
riempi:
	li $v0,5
	syscall				# riempimento vettore
	beq $v0,-1,menoUno
	sw $v0,0($a0)
	addi $a0,$a0,4
	j riempi
menoUno:
	sw $t8,0($a0)			# tutti gli altri valori settati a -1
	beq $a0,$s7,len
	addi $a0,$a0,4
	j menoUno
len:
la $a0,vettore
li $a1,0
cLen:
	lw $v0,0($a0)
	beq $v0,-1,comincia		# calcolo lunghezza vettore
	addi $a1,$a1,1
	addi $a0,$a0,4
	j cLen
comincia:
beq $a1,0,vettVuot			# se len==0: vettore vuoto
div $t0,$a1,2
li $t1,0
subi $t2,$a1,1
move $t8,$t2
li $t9,0
la $s6,vettore
jal reverse
stampa:
	beq $t9,$a1,fine
	lw $s7,0($s6)
	li $v0,1
	move $a0,$s7
	syscall
	addi $t9,$t9,1
	addi $s6,$s6,4
	j stampa	
	
vettVuot:
	li $v0,4
	la $a0,vettVuoto
	syscall
	j fine
reverse:
	subi $sp,$sp,12
	sw $ra,0($sp)
	sw $t1,4($sp)
	sw $t2,8($sp)
	addi $t1,$t1,1
	subi $t2,$t2,1
	bgt $t1,$t0,caso_base
	jal reverse
	
	sll $t3,$t1,2
	sll $t4,$t2,2
	lw $t5,vettore($t3)
	lw $t6,vettore($t4)
	sw $t6,vettore($t3)
	sw $t5,vettore($t4)
	
	
	lw $ra,0($sp)
	lw $t1,4($sp)
	lw $t2,8($sp)
	addi $sp,$sp,12
	jr $ra
	
caso_base:
	lw $ra,0($sp)
	lw $t1,4($sp)
	lw $t2,8($sp)
	addi $sp,$sp,12
	jr $ra
fine:
	li $v0,10
	syscall
	
	
