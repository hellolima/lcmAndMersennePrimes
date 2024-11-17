.data

primosMersenneVetor: .word 0 0 0 0 0 0 0 0 #conseguimos armazenar até o oitavo número primo de Mersenne

.text
            add s0, zero, zero
            addi a0, zero, 2 
            jal ra, eprimo
            addi t0, zero, 1
            bne a0,t0,teste2
            addi s0,s0,1
    teste2: addi a0, zero, 2
            jal ra, primosmersenne
            addi t0, zero, 7
            bne a0,t0, FIM
            addi s0,s0,1
            beq zero,zero, FIM

geramersenne:
                addi sp, sp, -20               	
                sw ra, 16(sp)                  	
                sw s0, 12(sp)                   	
                sw s1, 8(sp)                    	
                sw a0, 4(sp)                    	

                la t1, primosMersenneVetor     	
                addi t2, zero, 2               	# primeiro número primo: 2
                sw t2, 0(sp)					
                addi t0, zero, 0               	# contador de números Mersenne gerados

                loop_geramersenne:
                 	li t3, 1            # t3 = 1
    				sll t3, t3, t2      # t3 = 2^t2

                    addi t3, t3, -1            	# calcula 2^p - 1 (número de Mersenne)
                    mv a0, t3                   
                    jal ra, eprimo             	
                    bne a0, zero, not_prime        	# se não é primo, pula para o próximo

                    add_to_vector:
                        sw t3, 0(t1)     # adicionando no vetor o primo de Mersenne encontrado            	
                        addi t1, t1, 8                 	
                        addi t0, t0, 1                 	

                    not_prime:
                        addi t2, t2, 1                
                    
                        lw a0, 4(sp)                  # restaura o valor original de a0 (quantidade desejada de números de Mersenne)
                        bne t0, a0, loop_geramersenne # continua o loop enquanto não atingir a quantidade

                lw ra, 16(sp)       # atingiu a quantidade, nos preparando para sair           	
                lw s0, 12(sp)                    	
                lw s1, 8(sp)                    	
                lw a0, 4(sp)
                lw t2, 0(sp)
                addi sp, sp, 20                	
                jalr zero, 0(ra)                        	
               
eprimo: 
				addi sp, sp, -16                   
    			sw t0, 0(sp)                      
                sw t1, 4(sp)
                sw t2, 8(sp)
                sw ra, 12(sp)
                
				addi t0, zero, 2                  
    			rem t2, a0, t0                    # calcula o resto de 'n' por 2 e armazena em t2
    			bne t2, zero, eprimo_check_loop   # se resto != 0, vai para o loop de verificação de divisibilidade (é ímpar ou primo)
                addi a0, zero, 1                  # se 'n' for 2 ou divisível por 2, não é primo
                
                lw t0, 0(sp)
                lw t1, 4(sp)
                lw t2, 8(sp)
                lw ra, 12(sp)
                addi sp, sp, 16
                
    			jalr zero, 0(ra)                    
				eprimo_check_loop: # verifico ate raiz quadrada(n)
                    addi t0, t0, 1                    
                    mul t1, t0, t0                    
                    bge t1, a0, eprimo_is_prime       

                    rem t2, a0, t0                    
                    bne t2, zero, eprimo_check_loop   # se resto != 0, continua verificando

                    li a0, 1                          # se restou = 0, encontrou divisor, não é primo
                    
                    lw t0, 0(sp)
                    lw t1, 4(sp)
                    lw t2, 8(sp)
                    lw ra, 12(sp)
                    addi sp, sp, 16
                    
                    jalr zero, 0(ra)                    

				eprimo_is_prime:
                    li a0, 0  # se não encontrou divisor, é primo
                    
                    lw t0, 0(sp)
                    lw t1, 4(sp)
                    lw t2, 8(sp)
                    lw ra, 12(sp)
                    addi sp, sp, 16 
                    
                    jalr zero, 0(ra)                    
primosmersenne:
            addi sp, sp, -12    
            la t1, primosMersenneVetor			# carrega o vetor
            sw a0, 4(sp)                      	# salva a0 (indice que queremos)
            sw ra, 0(sp)
            sw t1, 8(sp)
            
            jal ra, geramersenne              # gera apenas a quantidade necessária de números de Mersenne -> Ex.: se queremos o segundo, gero apenas dois primos de Mersenne para não realizar calculos sem necessidade

            lw a0, 4(sp)                      # restaura o índice desejado
            lw t1, 8(sp)						# restaura o vetor
            
            addi t0, a0, -1      # Subtrai 1 de a0 (para que a0=1, resulte em 0)
			slli t0, t0, 3       # Desloca t0 à esquerda por 3 bits, o que é equivalente a multiplicar por 8
                   
            add t1, t1, t0
            lw a0, 0(t1)
            
			lw ra, 0(sp)
            addi sp, sp, 12
            
            jalr zero, 0(ra)

FIM: add t0, zero, s0