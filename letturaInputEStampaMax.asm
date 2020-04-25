#ESEMPIO: PRENDE IN INPUT NUMERI FINCHè NON LEGGE LO ZERO, POI STAMPA IL MASSIMO TRA QUESTI.
.text
do:
li $v0,5                    #lettura intero in input
syscall
beq $v0,$zero, stampa       #condizione di uscita
sgt $t4,$v0,$t2             #setta $t4 a 1 se input>max
beq $t4,1,aggiornaMax
j do

aggiornaMax:               #aggiornamento max
move $t2,$v0
j do

stampa:                    #stampa
li $v0,1
move $a0,$t2
syscall
