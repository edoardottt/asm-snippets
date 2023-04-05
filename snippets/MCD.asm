# MASSIMO COMUN DIVISORE TRA DUE INTERI POSITIVI
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

loop:
	beq $s0,$s1,uguali
	bgt $s0,$s1,secondoCaso
	blt $s0,$s1,terzoCaso	
uguali:
	li $v0,1
	move $a0,$s0
	syscall
	li $v0,10
	syscall
secondoCaso:
	move $s2,$s1
	move $s1,$s0
	move $s0,$s2
	j loop
terzoCaso:
	sub $s1,$s1,$s0
	j loop