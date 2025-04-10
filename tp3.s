
@Exercice 9 :
.global _start
tab: .byte 0xc2, 0b11000011, 9, 252, 0xFF, 0x81, 0b10, 63, 0b11000101, 219
.align
_start:
	main:                      @Question 2
		MOV R3, #0 @tour de boucle
		MOV R5, #0
		ADR R2, tab
		boucle_main:
				 MOV R0, #0
				 CMP R3, #10
				 bhs end
				 LDRB R1, [R2], #1
				 bl estPalindrome
				 ADD R3, R3, #1
				 ADD R5, R5, R0
				 b boucle_main

	estPalindrome:          @Question 1
		STMFD sp!,{R2-R5, lr}
		MOV R0, #1
		MOV R2, #0b10000000
		MOV R3, #0b1
		boucle: CMP R2, R3 
				 bls fin_boucle
				 MOV R4, #0
				 MOV R5, #0
				 TST R1, R2
				 MOVEQ R4, #1
				 TST R1, R3
				 MOVEQ R5, #1
				 CMP R4, R5
				 MOVNE r0, #0
				 LSL R3, R3, #1
				 LSR R2, R2, #1
				 b boucle
		fin_boucle:
		LDMFD sp!,{R2-R5, pc}
end:
_exit: