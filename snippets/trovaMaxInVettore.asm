.data
vettore: .word  1,7,23,90,26,74,654,98,34,65,78,6,84,5,9,9  #vettore da scorrere
dim: .word 16                                               #dim vettore
.text
lw $t3,dim($zero)                                           
lw $t1,vettore($t0)
move  $t2,$t1                                               #imposto vettore[0] come primo massimo
mul $t3,$t3,4                                               #salvo in $t3 l'offset dell'ultimo elemento del vettore
for:
bge $t0,$t3,end                                             #condizione di uscita
lw $t1,vettore($t0)                                         #vettore[i]
bgt $t1,$t2,aggiornamentoMax                          
addi $t0,$t0,4                                              #aggiorno indice
j for                                                       #salto inc.

aggiornamentoMax:      
move $t2,$t1                                               #aggiornamento max        
addi $t0,$t0,4                                             #aggiorno indice
j for

end:                                                       #stampa max
li $v0,1
move $a0,$t2
syscall