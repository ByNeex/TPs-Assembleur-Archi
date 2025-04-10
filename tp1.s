
@TP1 Archi :

@Exercice 1 :
	.global _start
	_start:
		@nb1 : 9
		@nb2 : 6
		@ a : r0
		@ b : r3
		MOV r1, #10
		MOV r2, #20
		MOV r0, r1
		MOV r3, r2
	
		boucle: CMP r0, r3
			 	beq fin
			if:	 bls else
				 ADD r3, r3, r2
			else: bhs fin_if
			   	ADD r0, r0, r1
			fin_if:
			b boucle	 	 
		fin:
	_exit:

@Exercice 2 :
	@Question 1 :

		.global _start
		_start:
			@Question 1 :
			@ r1 : N
			@ r0 : valeur de 2^N
			@ r2 : i
	
		MOV r1, #5
		MOV r0, #1
		MOV r2, #0
		boucle: CMP r2, r1
			 	bhs fin_boucle
			 	LSL r0, r0, #1
			 	ADD r2, r2, #1
			 	b boucle
		fin_boucle:
	_exit:
	
	@Question 2 :
		
		.global _start
		_start:
			@Question 2 :
			@ r1 : valeeur de 2^N
			@ r0 : valeur de log2(N)
	
		MOV r1, #64
		MOV r0, #0
		boucle: CMP r1, #1
			 	beq fin_boucle
			 	MOV r1, r1, LSR #1
			 	ADD r0, r0, #1
			 	b boucle
		fin_boucle:
	_exit:

@Exercice 3:
	.global _start
	_start:
		@ r0 : valeur de la racine carrée entière d'un nombre N dans r1
		@ r1 : N
    		MOV r1, #19          
    		MOV r0, #0        

		boucle:
        		ADD r2, r0, #1    
        		MUL r2, r2, r2    
        		CMP r2, r1        
        		bhi end           
        		ADD r0, r0, #1       
       	 		b boucle
		end:
	_exit:


@Exercice 4 :

	.global _start
	_start:
		@ r0 : valeur de la racine carrée entière d'un nombre N dans r1
		@ r1 : N
   	 	MOV r1, #0b111000101011        
   	 	MOV r2, #7 
		MOV r3, #2
	
		LSR r1, r1, r3
	
		SUB r4, r2, r3
		ADD r4, r4, #1
		MOV r5, #1
		LSL r5, r5, r4
		SUB r5, r5, #1
	
		AND r0, r1, r5
	_exit:


