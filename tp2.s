TP2 : Archi

@Exercice 5 :
	.global _start
		a: .byte 8
		b: .byte 12
		somme: .fill 1,1
		.align
	_start:
		ADR R0, somme
		ADR R1, a
		ADR R2, b
		LDRB R3, [R1]
		LDRB R4, [R2]
		ADD R5, R3, R4
		STRB R5, [R0]
	
	_exit:
	
@Exercice 6 :	
.global _start
@ i : R0
@ minindex : R1
@ j: R2
@ tab : R3
@ tab[j] : R4
@ tab[minindex] : R5
@ tmp : R6
@ tab[i] : R7
.equ N, 10
tab: .word 22, -12, 0, 9, 5, -1, 5, 43, 10, -10
.align
_start:
MOV R0, #0
ADR R3, tab
b1: CMP R0, #N-1
	 bge fin_b1
	 MOV R1, R0
	 MOV R2, R0
	 ADD R2, R2, #1 @ j = i + 1
	 b2: CMP R2, #N  
	 	  bge fin_b2
	 	  LDR R4, [R3, R2,LSL #2]
		  LDR R5, [R3, R1,LSL #2]
	  	  if1: CMP R5, R4
		  		MOVGE R1, R2
		  fin_if1:
		  ADD R2, R2, #1
		  b b2
	 fin_b2:
	 if2: CMP R1, R0
	       beq fin_if2
		   LDR R7, [R3, R0,LSL#2]
		   LDR R5, [R3, R1,LSL #2]
		   MOV R6, R7
		   STR R5, [R3, R0,LSL #2]
		   STR R6, [R3, R1,LSL #2]
		   
	 fin_if2:
	 ADD R0, R0, #1
	 b b1
fin_b1:
	
_exit:
	
@Exercice 7 :	
.global _start
message: .asciz "DTCXQXQWURQWXGBRCUUGTCNGZGTEKEGUWKXCPV"
dec: .word 2
.align
_start:
	ADR R0, message
	ADR R3, dec
	LDRB R2, [R3]
	boucle:
		LDRB R1, [R0]
		CMP R1, #0
		beq fin
		SUB R1, R1, R2
		if: CMP R1, #65
			 bge fin_if
			 ADD R1, R1, #26 
		fin_if:
		STRB R1, [R0], #1
		b boucle
	fin:
_exit:

@Exercice 8 :	
.global _start
chaine1: .asciz "JLkd2nj345bnzApdd0j9"
chaine2: .fill 255,1
.align
_start:
	LDR R0, =chaine1 
	LDR R2, =chaine2    @problème de valeru trop grande donc on passe a LDR quand c une cte trop grande
	LDR R3, =0x30
	LDR R4, =0x39
	boucle:
		LDRB R1, [R0], #1
		CMP R1, #0
		beq fin
		if: CMP R1, R3
		     blt fin_if
			 CMP R1, R4
			 bgt fin_if
			 b boucle
		fin_if:
			STRB R1, [R2], #1
			b boucle	
	fin:
_exit:





