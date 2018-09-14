# RUOTARE UN VETTORE SENZA STRUTTURA DI APPOGGIO
.data
vettore: .word 100:1
richiesta: .asciiz "inserire interi positivi da salvare sul vettore (max 100), -1 per terminare\n"
vettVuoto: .asciiz "vettore vuoto\n"

.text
li $t8,-1
li $v0,4
la $a0,richiesta
syscall
la $a0,vettore
addi $s7,$a0,400
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
	scorri:
		bge $t1,$t0,stampaReverse # se ho finito stampo il vettore
		sll  $t3,$t1,2
		sll  $t4,$t2,2
		lw $t5,vettore($t3)	# v[i] inizio
		lw $t6,vettore($t4)	# v[j] fine
		sw $t6,vettore($t3)	# li scambio
		sw $t5,vettore($t4)
		addi $t1,$t1,1		# i++
		subi $t2,$t2,1		#j--
		j scorri
		
stampaReverse:
la $s0,vettore
sll $a3,$a1,2
add $s1,$s0,$a3
stampa:					# ciclo che stampa i valori del nuovo vettore
	bge $s0,$s1,fine
	lw $s2,0($s0)
	li $v0,1
	move $a0,$s2
	syscall
	addi $s0,$s0,4
	j stampa
fine:
li $v0,10
syscall

vettVuot:
li $v0,4
la $a0,vettVuoto
syscall
li $v0,10
syscall
	
	
	
	
	
