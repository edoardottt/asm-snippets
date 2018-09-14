#Mergesort

.data
A: .word 1,3,5,7,9,11,13,15
LA: .word 8
B: .word 2,4,6,8,10,12,14
LB: .word 7
C: .word 0:15
LC: .word 15
.eqv V_A $s0
.eqv V_B $s1
.eqv V_C $s2
.eqv APPO $s3
.eqv L_A $s4
.eqv L_B $s5
.eqv L_C $s6
.eqv LAPPO $s7
.text
main:

	la V_A,A
	la V_B,B
	la V_C,C
	lw L_A,LA
	lw L_B,LB 
	lw L_C,LC
	
	jal merge
	
	 li $v0,10
	 syscall

#
#merge(A,B,C,LA,LB,LC)
merge:
	subu $sp,$sp,4
	sw $ra,0($sp)
	
	seq $t0,L_A,$zero
	seq $t1,L_B,$zero
	and $t0,$t0,$t1
	bnez $t0,esci_merge
	
	bnez L_A,controlla_LB
	
	# A è vuoto
	
	# preservo su stack roba
	
	lw $t0,(V_B)
	sw $t0,(V_C)
	addi V_B,V_B,4
	addi V_C,V_C,4
	subi L_B,L_B,1
	subi L_C,L_C,1
		
	jal merge
	
	#recupero da stack roba
	lw $ra,0($sp)
	addu $sp,$sp,4
	jr $ra
controlla_LB:
	bnez L_B, A_e_B_non_vuoti
	
	# B è vuoto 
	
	#salvare su stack roba
	
	move $t0,V_A
	move V_A,V_B
	move V_B,$t0
	
	move $t0,L_A
	move L_A,L_B
	move L_B,$t0
	
	jal merge
	
	#ripristino da stack roba
	lw $ra,0($sp)
	addu $sp,$sp,4
	jr $ra
	
A_e_B_non_vuoti:
	lw $t0,(V_A)
	lw $t1,(V_B)
	
	ble $t0,$t1,minore_A0_B0
	
	#salvo roba su stack
	
	#A[0] > B[0]
	sw $t1,(V_C)
	addi V_B,V_B,4
	addi V_C,V_C,4
	subi L_B,L_B,1
	subi L_C,L_C,1
	
	jal merge
	
	# ripristino su stack roba
	lw $ra,0($sp)
	addu $sp,$sp,4
	jr $ra
	
minore_A0_B0:
		
	#salvo roba su stack

	#A[0] -> C[0]
	sw $t0,(V_C)
	addi V_A,V_A,4
	addi V_C,V_C,4
	subi L_A,L_A,1
	subi L_C,L_C,1
	
	jal merge
esci_merge:	
	# ripristino su stack roba
	lw $ra,0($sp)
	addu $sp,$sp,4
	jr $ra
	
	
#mergesort(V_A,V_B,V_APPO,L_A,L_B,L_APPO)

MERGE_SORT:
	#salvo tutto su stack
	
	#se L_A==0 non fa niente
	beqz L_A, esci_merge_sort
	
	
	#se L_A==1 copio A[0]->B[0] 
	beq L_A,1,copia_primo_e_esci
	#calcolo L_A0 e L_A1
	sra $t0,L_A,1            #L_0
	sub $t1,L_A,$t0          #L_1
	sll $t2,$t0,2            #L_0*4
	add $t3,V_A,$t2          #V_A1
	add $t4,V_B,$t2          #V_B1
	add $t5,V_APPO,$t2       #V_APPO1
	
	move $t6,V_B
	move V_B,V_APPO
	move V_APPO, $t6ù
	
	move L_A,$t0
	
	jal MERGE_SORT
	
	move V_A,$t3
	move V_B,$t5
	move V_APPO,$t4
	move L_A,$t1
	 
	jal MERGE_SORT
	#slavo roba su stack usata da merge
	
	move V_A,V_APPO
	move V_B, $t5
	move V_C, V_B
	move L_C,L_A
	move L_A, $t0
	move L_B,$t1 

	