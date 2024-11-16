.data
##### R1 START MODIFIQUE AQUI START #####
#
# Este espaço é para você definir as suas constantes e vetores auxiliares.
#
primosMersenneVetor: .word 0 0 0 0 0 0 0 0 #conseguimos armazenar até o oitavo número primo de Mersenne

##### R1 END MODIFIQUE AQUI END #####
.text
            add s0, zero, zero
            addi a0, zero, 15#la a0, 4 
            jal ra, eprimo
            addi t0, zero, 0
            bne a0,t0,teste2
            addi s0,s0,1
    teste2: addi a0, zero, 2
            jal ra, primosmersenne
            addi t0, zero, 7
            bne a0,t0, FIM
            addi s0,s0,1
            beq zero,zero, FIM


##### R2 START MODIFIQUE AQUI START #####
# Esse espaço é para você escrever o código dos procedimentos.
# Por enquanto eles estão vazios

geramersenne:
                addi sp, sp, -20               	# Aloca espaço para salvar registradores sujos
                sw ra, 12(sp)                  	# Salva o endereço de retorno
                sw s0, 8(sp)                   	# Salva o valor de s0
                sw s1, 4(sp)                   	# Salva o valor de s1
                sw a0, 0(sp)                   	# Salva o valor de a0

                la t1, primosMersenneVetor     	# Carrega o endereço do vetor primosMersenneVetor
                addi t2, zero, 2               	# Começa com o primeiro número primo: 2
                sw t2, 16(sp)					#guardando t2 na pilha, ele que calcula 2^p
                addi t0, zero, 0               	# Inicializa contador de números Mersenne gerados

                loop_geramersenne:
                 	li t3, 1            # t3 = 1
    				sll t3, t3, t2      # t3 = 2^t2

                    addi t3, t3, -1            	# Calcula 2^p - 1 (número de Mersenne)
                    mv a0, t3                   # Coloca o número de Mersenne em a0
                    jal ra, eprimo             	# Verifica se 2^p - 1 é primo
                    bne a0, zero, not_prime        	# Se não é primo, pula para o próximo

                    add_to_vector:
                        sw t3, 0(t1)                   	# Armazena o número de Mersenne no vetor
                        addi t1, t1, 4                 	# Avança o ponteiro para a próxima posição do vetor
                        addi t0, t0, 1                 	# Incrementa o contador de primos Mersenne gerados

                    not_prime:
                        addi sp, sp, 4                # Aloca espaço para salvar temporariamente valores
                        addi t2, t2, 1                # Incrementa p para o próximo número de Mersenne
                    
                        lw a0, 0(sp)                  # Restaura o valor original de a0 (quantidade desejada de números de Mersenne)

                        addi sp, sp, -4               # Ajusta a pilha antes de continuar
                        sw t2, 16(sp)                 # Guarda t2 atualizado na pilha novamente

                        bne t0, a0, loop_geramersenne # Continua o loop enquanto não atingir a quantidade 'qtd'

                lw ra, 12(sp)                  	# Restaura ra antes de retornar
                lw s0, 8(sp)                    	# Restaura o valor de s0
                lw s1, 4(sp)                    	# Restaura o valor de s1
                lw a0, 0(sp)                    	# Restaura o valor original de a0
                addi sp, sp, 20                	# Desaloca espaço da pilha
                jalr ra, 0(ra)                 	# Retorna ao ponto de chamada

               
eprimo: 
				addi sp, sp, -12                   # Aloca espaço na pilha
    			sw t0, 0(sp)                      
                sw t1, 4(sp)
                sw t2, 8(sp)
				addi t0, zero, 2                  # Inicializa t0 com 2 (primeiro número para verificar)
    			rem t2, a0, t0                    # Calcula o resto de 'n' por 2 e armazena em t2
    			bne t2, zero, eprimo_check_loop   # Se resto != 0, vai para o loop de verificação de divisibilidade
                addi a0, zero, 1                  # Se 'n' for 2 ou divisível por 2, não é primo
                lw t2, 8(sp)
                addi sp, sp, 12
    			jalr ra, 0(ra)                    # Retorna para o ponto de chamada
				eprimo_check_loop:
                    addi t0, t0, 1                    # Incrementa t0 (verificando de 2 até n//2)
                    mul t1, t0, t0                    # Multiplica t0 por t0
                    bge t1, a0, eprimo_is_prime       # Se t0*t0 >= n, sai do loop (n é primo)

                    rem t2, a0, t0                    # Calcula o resto de 'n' / 't0' e armazena em t2
                    bne t2, zero, eprimo_check_loop   # Se resto != 0, continua verificando

                    li a0, 1                          # Se encontrou divisor, não é primo
                    lw t0, 0(sp)
                    lw t1, 4(sp)
                    lw t2, 8(sp)
                    addi sp, sp, 12
                    jalr ra, 0(ra)                    # Retorna para o ponto de chamada

				eprimo_is_prime:
                    li a0, 0  # Se não encontrou divisor, é primo
                    lw t0, 0(sp)
                    lw t1, 4(sp)
                    lw t2, 8(sp)
                    addi sp, sp, 8 
                    jalr ra, 0(ra)                    # Retorna para o ponto de chamada
primosmersenne: 
                #addi sp, sp, -8                  	# Salvar o valor de retorno na pilha
                #sw a0, 0(sp)                     	# Salva 'n' na pilha
                addi t0, zero, 0                 	# t0 é o índice para preencher primos_mersenne
                jal ra, geramersenne
                #lw a0, 0(sp)
                #lw t0, 4(sp)
                #lw t1, 8(sp)
                #lw t2, 12(sp)
                #addi sp, sp, 8
                jalr zero, 0(ra)
##### R2 END MODIFIQUE AQUI END #####
FIM: add t0, zero, s0