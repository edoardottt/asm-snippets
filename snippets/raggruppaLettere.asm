# RAGGRUPPA TUTTE LE LETTERE ALL'INIZIO E GLI ALTRI CARATTERI ALLA FINE
.data
richiesta: .asciiz "inserire una stringa (max 100 caratteri)\n"
stringa: .space 31

.text
li $v0,4
la $a0,richiesta
syscall
li $v0,8
la $a0,stringa
la $a1,30
syscall
len:
	lb $s0,stringa($s1)
	beq $s0,10,main
	addi $s1,$s1,1
	addi $s2,$s2,1
	j len
main:
	subi $s2,$s2,1
	jal raggruppa
	li $v0,4
	la $a0,stringa
	syscall
	li $v0,10
	syscall
raggruppa:
	bge $t0,$s2,JR
	lb $t1,stringa($t0)
	j verifica
	
scambia:
	lb $t8,stringa($s2)
	sb $t1,stringa($s2)
	sb $t8,stringa($t0)
	subi $s2,$s2,1
	j raggruppa
verifica:
	sle $t2,$t1,'Z'
	sge $t3,$t1,'A'
	and $t4,$t2,$t3
	sle $t2,$t1,'z'
	sge $t3,$t1,'a'
	and $t5,$t2,$t3
	or $t6,$t4,$t5
	beq $t6,0,scambia
	addi $t0,$t0,1
	j raggruppa
JR:
	jr $ra
	