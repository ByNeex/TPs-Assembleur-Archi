.global _start
cuve_pleine: .byte 0
afficheur7seg:
	.byte 0x3F   @ 0
    .byte 0x06   @ 1
    .byte 0x5B   @ 2
    .byte 0x4F   @ 3
    .byte 0x66   @ 4
    .byte 0x6D   @ 5
    .byte 0x7D   @ 6
positions_tambour: .word 0x3000, 0x2100, 0x0101, 0x0003, 0x0006, 0x000c, 0x0808, 0x1800, 0x3000
fin_positions_tambour:
.align
_start:
	@Question 7 :
	main:
		boucle_infinie:
			bl eteindre_leds
			bl eteindre_tambour
			MOV R1, #0
			bl afficher_temperature
			allumage:
				LDR R0, =0xFF200040         
    			LDR R1, [R0]
    			TST R1, #1                  
    			BEQ allumage
			fin_allumage:
			attente_prog:
				LDR R0, =0xFF200050
				LDR R1, [R0]
				TST R1, #0b1
				bne programme0
				TST R1, #0b10
				bne programme1
				TST R1, #0b100
				bne programme2
				bl verifier_allumage
				b attente_prog
			fin_attente_prog:
			
			programme0:
				bl verifier_allumage
				bl remplir
				bl verifier_allumage
				MOV R1, #3
				bl chauffer
				bl verifier_allumage
				MOV R0, #0
				lavage:
					boucle_lavage:
						CMP R0, #2
						bhs fin_boucle_lavage
						MOV R1, #0
						MOV R2, #0
						MOV R3, #1
						bl tourner_tambour
						bl verifier_allumage
						MOV R1, #1
						MOV R3, #1
						ADD R0, R0, #1
						bl tourner_tambour
						bl verifier_allumage
						b boucle_lavage
					fin_boucle_lavage:
				MOV R0, #0
				essorage:
					boucle_essorage:
						CMP R0, #2
						bhs fin_boucle_essorage
						MOV R1, #0
						MOV R2, #1
						MOV R3, #3
						bl tourner_tambour
						bl verifier_allumage
						MOV R1, #1
						MOV R3, #3
						ADD R0, R0, #1
						bl tourner_tambour
						bl verifier_allumage
						b boucle_essorage
					fin_boucle_essorage:
				bl vider
				b boucle_infinie
				
			programme1:
				bl verifier_allumage
				bl remplir
				bl verifier_allumage
				MOV R1, #6
				bl chauffer
				bl verifier_allumage
				MOV R0, #0
				lavage1:
					boucle_lavage1:
						CMP R0, #3
						bhs fin_boucle_lavage1
						MOV R1, #0
						MOV R2, #0
						MOV R3, #2
						bl tourner_tambour
						bl verifier_allumage
						MOV R1, #1
						MOV R3, #2
						ADD R0, R0, #1
						bl tourner_tambour
						bl verifier_allumage
						b boucle_lavage1
					fin_boucle_lavage1:
				MOV R0, #0
				essorage1:
					boucle_essorage1:
						CMP R0, #2
						bhs fin_boucle_essorage1
						MOV R1, #0
						MOV R2, #1
						MOV R3, #3
						bl tourner_tambour
						bl verifier_allumage
						MOV R1, #1
						MOV R3, #3
						ADD R0, R0, #1
						bl tourner_tambour
						bl verifier_allumage
						b boucle_essorage1
					fin_boucle_essorage1:
				bl vider
				b boucle_infinie
				
			programme2:
				bl verifier_allumage
				bl remplir
				bl verifier_allumage
				MOV R0, #0
				essorage2:
					boucle_essorage2:
						CMP R0, #4
						bhs fin_boucle_essorage2
						MOV R1, #0
						MOV R2, #1
						MOV R3, #2
						bl tourner_tambour
						bl verifier_allumage
						MOV R1, #1
						MOV R3, #2
						ADD R0, R0, #1
						bl tourner_tambour
						bl verifier_allumage
						b boucle_essorage2
					fin_boucle_essorage2:
				bl vider
				b boucle_infinie
				
				
				
	verifier_allumage:
		STMFD sp!,{R0, R1, lr}
		LDR R0, =0xFF200040
		LDR R1, [R0]
		TST R1, #0b1
		bne bien_allumer
		bl vider
		b boucle_infinie
		bien_allumer:
		LDMFD sp!,{R0, R1, pc}
	
	eteindre_tambour:
		STMFD sp!,{R0, R1, lr}
		LDR R0, =0xFF200020
		LDR R1, =0x0
		STR R1, [R0]
		LDMFD sp!,{R0, R1, pc}
	
	eteindre_leds:
		STMFD sp!,{R0, R1, lr}
		LDR R0, =0xFF200000
		LDR R1, =0b0
		STR R1, [R0]
		LDMFD sp!,{R0, R1, pc}
	
	
	@Question 6 :
	tourner_tambour:
		STMFD sp!,{R0, R4, R5, R6, R7, R8, lr}
		LDR R0, =0xFF200020
		MOV R4, #0
		vitesse_lente:
			CMP R2, #0
			MOVEQ R8, #5
		vitesse_rapide:
			MOVNE R8, #1
		boucle_tambour:
			CMP R4, R3
			bhs fin_boucle_tambour
			MOV R7, #0
			partir_droite:
				CMP R1, #0
				ADREQ R5, positions_tambour
			partir_gauche:
				ADRNE R5, fin_positions_tambour
				SUBNE R5, R5, #4
			boucle_2:
				CMP R7, #8
				bhi fin_boucle_2
				LDR R6, [R5]
				STR R6, [R0]
				CMP R1, #0
				ADDEQ R5, R5, #4
				SUBNE R5, R5, #4
				bl waitn
				ADD R7, R7, #1
				b boucle_2
				fin_boucle_2:
			ADD R4, R4, #1
			b boucle_tambour
		fin_boucle_tambour:
		LDMFD sp!,{R0, R4, R5, R6, R7, R8, pc}
		

	@Question 5 :
	afficher_temperature:
		STMFD sp!,{R0, R2, R3, R4, lr}
		LDR R0, =0xFF200030
		LDR R2, =afficheur7seg
		LDRB R3, [R2, R1]	@ on charge l'afficheur 7 segment de la valeur de R1
		LDRB R4, [R2]       @ toujours 0 pour les unité
		LSL R3, R3, #8      @ on se décale de 8 bits donc un afficheur 7-segments
		ADD R3, R3, R4
		STR R3, [R0]
		LDMFD sp!,{R0, R2, R3, R4, pc}
	
	chauffer:
		STMFD sp!,{R0-R2, R8, lr}
		LDR R0, =0xFF200030
		MOV R2, R1
		MOV R1, #0
		MOV R8, #5
		boucle_chauffer: 
			CMP R1, R2
			bhi fin_boucle_chauffer
			bl afficher_temperature
			bl waitn
			ADD R1, R1, #1
			b boucle_chauffer
		fin_boucle_chauffer:
		LDMFD sp!,{R0-R2, R8, pc}
		
	
	@Question 3 :
	 remplir:
	 	STMFD sp!,{R0-R3, R8, lr}
		ADR R0, cuve_pleine
		MOV R1, #0b0000000001
		LDR R2, =0xFF200000
		MOV R8, #5
		MOV R3, #0
		boucle_remplir:
			CMP R3, #10 @10 leds
			bhs fin_boucle_remplir
			STR R1, [R2]
			bl waitn
			ADD R3, R3, #1
			ADD R1, R1, R1
			ADD R1, R1, #1
			b boucle_remplir
		fin_boucle_remplir:
		MOV R1, #1
		STRB R1, [R0]
		LDMFD sp!,{R0-R3, R8, pc}
	
	
	@Question 4 :
	vider:
		STMFD sp!,{R0-R3, lr}
		ADR R0, cuve_pleine
		MOV R1, #0b0111111111
		LDR R2, =0xFF200000
		MOV R8, #5
		MOV R3, #0
		boucle_vider:
			CMP R3, #10
			bhs fin_boucle_vider
			STR R1, [R2]
			bl waitn
			ADD R3, R3, #1
			LSR R1, R1, #1
			b boucle_vider
		fin_boucle_vider:
		MOV R1, #0
		STRB R1, [R0]
		LDMFD sp!,{R0-R3, pc}
		
		
	 @Question 2 :
	 waitn:
	 	STMFD sp!,{R0, lr}
		MOV R0, #0
		boucle_waitn: CMP R0, R8
				 bhs fin_boucle_waitn
				 bl wait1
				 ADD R0, R0, #1
				 b boucle_waitn
		fin_boucle_waitn:
		LDMFD sp!,{R0, pc}
		
	
		@Question 1 :
		wait1: 
			STMFD sp!,{R0, R1, lr}
			MOV R0, #0
			LDR R1, =0x1FFFF
			boucle_wait1: CMP R0, R1
					 bhs fin_boucle_wait1
					 ADD R0, R0, #1
					 b boucle_wait1
			fin_boucle_wait1:
			LDMFD sp!,{R0, R1, pc}
end:	
_exit: