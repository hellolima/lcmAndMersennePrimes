.data
##### R1 START MODIFIQUE AQUI START #####
#
# Este espaço é para você definir as suas constantes e vetores auxiliares.
#
vetor: .word 1 2 3 4 5 6 7 8 9 10
##### R1 END MODIFIQUE AQUI END #####

.text
        	add s0, zero, zero     
        	addi a0, zero, 10     
        	addi a1, zero, 2     
        	jal ra, mmc   		 
        	addi t0, zero, 10    
        	bne a0,t0,teste2    
        	addi s0,s0,1   	 
       	 
	teste2: addi a0, zero, 6    
        	addi a1, zero, 4    
        	jal ra, mmc   		 
        	addi t0, zero, 12   
        	bne a0,t0, FIM   	 
        	addi s0,s0,1   	 
        	beq zero,zero,FIM    
   	 
	##### R2 START MODIFIQUE AQUI START #####
	mmc:     # calculei utilizando o mdc
   		addi s3, a0, 0  	# s3 vai receber a
        addi s4, a1, 0   	 # s4 vai receber b
   		addi s5, s5, -1   	 # o resto vai começar com -1
        addi s6, zero, 0  	 # resultado de divisao de a por b
        	mdcLoop:
				rem s6, a0, a1     # calculando o resto da divisao e armazenando em s6
				addi s5, s6, 0     # passando esse valor para s5
				addi a0, zero, 0 # zerando a
				addi a0, a1, 0   # a recebe b
				addi a1, zero, 0 # zerando b
				addi a1, s5, 0   # b recebe o resto
				bne s5, zero, mdcLoop  # se o resto for diferente de 0, vai pro loop

         	mul s7, s3, s4
         	div x10, s7, a0
         	jalr zero, 0(ra)
    
	##### R2 END MODIFIQUE AQUI END #####
	FIM: addi t0, s0, 0
