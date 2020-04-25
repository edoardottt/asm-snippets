.text
 #ESEMPIO CICLO FOR
 xor $t0,$t0,$t0         #inizializzazione registro (indice) a zero.
 for:
 beq $t0,60,endFor       #condizione di uscita dal ciclo
 addi $t1,$t1,1          #aggiornamento variabile 
 addi $t0,$t0,1          #aggiornamento indice
 j for                   #salto incondizionato
 endFor:
 li $v0,1                #stampa valore finale
 move $a0,$t1
 syscall
 
 