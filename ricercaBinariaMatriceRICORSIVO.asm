# RICERCA DI UN ELEMENTO X IN UNA MATRICE NxM CON ELEMENTI NELLE RIGHE IN ORDINE CRESCENTE, MA NESSUNA RELAZIONE TRA LE DIVERSE RIGHE.

.data

richiesta: .asciiz "inserire un intero n positivo\n"
matrice: .word 91:1
si: .asciiz "è presente\n"
no: .asciiz "non è presente\n"

.text

li $v0,4
la $a0,richiesta
syscall				# richiesta e lettura input
li $v0,5
syscall
move $a1,$v0

la $a0,matrice
li $t0,0
li $t1,0
li $t2,91
sll $t2,$t2,2			# preparazione offset e valori utili nelle funzioni
subi $t5,$t2,4
add $t4,$a0,$t5
li $t5,12
sll $t5,$t5,2
add $t5,$a0,$t5
li $t6,78
sll $t6,$t6,2
add $v0,$a0,$t6
riempi:
	bge $t0,$t2,ciclo		# riempo la matrice ( in modo semplice) da 1 a 90 (0-12,13-25...)
	sw $t1,matrice($t0)
	addi $t0,$t0,4
	addi $t1,$t1,1
	j riempi
ciclo:
	bgt $a0,$v0,stampaNo		# se supero l'ultima riga stampa non è presente
	bgt $t5,$t4,stampaNo
	lw $s0,0($a0)
	lw $s4,0($t5)
	slt $s1,$a1,$s0
	sgt $s2,$a1,$s4			# se x<v[inizio riga] or x>[fine riga]
	or $s3,$s1,$s2			# salto la riga e passo alla prossima
	beq $s3,1,saltariga
	li $a2,0
	li $a3,12
	jal ricBin			# altrimenti salto a ricBin
	addi $a0,$a0,52
	addi $t5,$t5,52
	j ciclo
saltariga:
	addi $a0,$a0,52
	addi $t5,$t5,52
	j ciclo
ricBin:
	subi $sp,$sp,12			# allocazione stack
	sw $ra,0($sp)
	sw $a2,4($sp)
	sw $a3,8($sp)
	
	bgt $a2,$a3,caricaNO		# se i>j salto alla prossima riga
	add $t0,$a2,$a3			# m=(i+j)/2
	div $t0,$t0,2
	sll $t1,$t0,2
	add $k0,$a0,$t1			# mi preparo il vettaro all'offset m
	lw $t3,0($k0)
	beq $t3,$a1,stampaSi		# se x==v[m] stampo è presente
	bge $t3,$a1,ret			# se x>v[m] =====> ret
	addi $a2,$t0,1			# else i=m+1
	jal ricBin			# chiamata ricorsiva
	
	lw $ra,0($sp)
	lw $a2,4($sp)
	lw $a3,8($sp)
	addi $sp,$sp,12			# ripristino stack
	jr $ra
caricaNO:
	lw $ra,0($sp)
	lw $a2,4($sp)
	lw $a3,8($sp)
	addi $sp,$sp,12
	jr $ra
ret:
	subi $a3,$t0,1			# j=m-1
	jal ricBin			# chiamata ricorsiva
	lw $ra,0($sp)
	lw $a2,4($sp)
	lw $a3,8($sp)
	addi $sp,$sp,12
	jr $ra
stampaSi:
	li $v0,4
	la $a0,si
	syscall
	li $v0,10
	syscall
stampaNo:
	li $v0,4
	la $a0,no
	syscall
	li $v0,10
	syscall
	
	
	
	
	
	
