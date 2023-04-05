.data
testo1: .space 101
testo2: .space 101
vettoreascii: .byte '[','/',']','^','_','`','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','{','|','}','~','!','"','#','$','%','&','(',')','*','+',',','-','.','/','0','1','2','3','4','5','6','7','8','9',':',';','<','=','>','?','@','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',' ',
anagramma: .asciiz "ANAGRAMMA"
simili: .asciiz "SIMILI"
diversi: .asciiz "DIVERSI"
.text
.globl main
main:
	li $v0, 8                                                       #leggo il testo1 in  input
	la $a0, testo1
	la $a1, 101
	syscall
	li $v0, 8                                                       #leggo il testo2 in  input
	la $a0, testo2
	la $a1, 101
	syscall
	la $t0, testo1                                                  #carico in $t0 il testo1
	la $t1, testo2 							#carico in $t1 il testo2
	la $t6, vettoreascii                                                  #carico in $t6 il vettoreascii
	scorrivettore:        
	lb $t3,0($t6)                                                   #carico in $t3 l'indirizzo dell'i-esimo valore di vettoreascii
	beq $t3,'\0',stampa                                     		#se il vettore � finito stampo
		contaoccorrenzetesto1:
		lb $t2,0($t0)                                           #carico in $t2 l'i-esimo valore di testo1         
		beq $t2,'\0',contaocctesto2                             #se la stringa � finita vado a contaocctesto2
		beq $t2,$t3,aggiungioccparziale1                        #se $t2 e $t3 sono uguali aggiungo un'occorrenza parziale    
		addi $t0,$t0,1 						#passo al valore successivo
		j contaoccorrenzetesto1
		
				aggiungioccparziale1:
				addi $s4,$s4,1                          #aggiungo un'occorrenza 
				addi $t0,$t0,1                          #passo al valore successivo
				j contaoccorrenzetesto1
				
				contaocctesto2:
				lb $t7,0($t1)                           #carico in $t7 l'i-esimo valore di testo2                   
				beq $t7,'\0',aggiornacontfinale         #se testo2 � finito aggiorno il contatore finale                     
				beq $t7,$t3,aggiungioccparziale2        #se $t7 e $t3 sono uguali aggiungo un'occorrenza parziale                      
				addi $t1,$t1,1                          #passo al valore successivo
				j contaocctesto2
					aggiungioccparziale2:
					add $s5,$s5,1                   #aggiungo un'occorrenza
					addi $t1,$t1,1 			#passo al valore successivo
					j contaocctesto2
		
		
		aggiornacontfinale:
		sub $s3, $s4, $s5					#calcolo la differenza parziale
		abs $s3,$s3						#setto ad assoluto il valore di $t3
		add $t5,$t5,$s3						#la aggiungo al contatore finale
		li $s4,0
		li $s5,0
		addi $t6,$t6,1						#passo al valore del vettoreascii successivo
		la $t0,testo1
		la $t1,testo2
		j scorrivettore
		
		stampa:
		beq $t5,0, anag                                         #se la differenza � 0 stampa ANAGRAMMA
		beq $t5,1,simil						#se la differenza � 1 o 2 stampa SIMILI
		beq $t5,2,simil
		bge $t5,3,diver						#se la differenza � >= 3 stampa DIVERSI
		
		anag:
		li $v0,4
		la $a0,anagramma
		syscall
		j termina
		
		simil:
		li $v0,4
		la $a0,simili
		syscall
		j termina
		diver:
		li $v0,4
		la $a0,diversi
		syscall
		j termina
		
		termina:
		li $v0,10
		syscall
