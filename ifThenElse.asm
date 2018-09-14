.text
# ESEMPIO IF THEN ELSE
subi $t0,$t0,4
blez $t0,else
addi $t1,$t1,1 #$t0>0
j codicePost
else:
#$t0<0

codicePost:#se $t0>0,stampa 1
li $v0,1
move $a0,$t0
syscall
