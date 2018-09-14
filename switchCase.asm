#ESEMPIO SWITCH CASE
.data
dest: .word caso0,caso1,caso2,caso3   #label if

.text
addi $t0,$t0,3                   #valore indice (i)
sll $t0,$t0,2                    #i*4
lw $t1,dest($t0)                 #carico in $t1 l'indirizzo della label che mi interessa
jr $t1                           #salto inc. alla label

caso0:                           #VARI CASI 
xor $t2,$t2,$t2
j end
caso1:
addi $t2,$t2,111
j end
caso2:
addi $t2,$t2,222
j end
caso3:
addi $t2,$t2,333
j end

end:
li $v0,1                        # stampa a seconda dell'input di i
move $a0,$t2
syscall