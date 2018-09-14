.text
# ESEMPIO WHILE DO
addi $t0,$t0,100     #valore iniziale $t0
while:
beqz $t0,endWhile    #condizione per uscire dal ciclo
subi $t0,$t0,1       #aggiorno valore
j while              #salto incondizionato
endWhile:
li $v0,1
move $a0,$t0         #stampa il valore (0)
syscall
