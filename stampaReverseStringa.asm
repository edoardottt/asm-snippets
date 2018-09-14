# NON FUNZIONANTE DA RIVEDERE
.data
richiesta: .asciiz "inserisci una stringa (max 100 caratteri)"
stringa: .asciiz
vettore: .byte 100:1
.text
li $v0,4
la $a0,richiesta
syscall
li $v0,8
la $a0,stringa
li $a1,101
syscall
len:
	lb $t0,0($a0)
	beq $t0,'\n',revers
	addi $t1,$t1,1
	addi $a0,$a0,1
	j len
revers:
	la $a0,stringa
	subi $t2,$t1,1
	add $a0,$a0,$t2
	li $s0,0
	ciclo:
		beq $s0,$t2,stampa
		lb $t0,0($a0)
		sb $t0,vettore($s0)
		addi $s0,$s0,1
		subi $a0,$a0,1
		j ciclo
stampa:
	li $v0,4
	la $a0,vettore
	syscall