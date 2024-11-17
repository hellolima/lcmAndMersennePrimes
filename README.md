# RISC-V Assembly: Cálculo de MMC e Números Primos de Mersenne

Este repositório contém implementações em Assembly RISC-V para o cálculo do **MMC** (Mínimo Múltiplo Comum) entre dois números e **geração de números primos de Mersenne**, além da **verificação da primalidade**,. A implementação foi feita com o objetivo de demonstrar como manipular números inteiros e aplicar conceitos matemáticos básicos utilizando a arquitetura RISC-V.

## Funcionalidades

### 1. Cálculo do MMC entre dois números

A função para calcular o MMC entre dois números inteiros \(a\) e \(b\) segue o algoritmo baseado na fórmula:

 $MMC(a, b) = \frac{|a \times b|}{MDC(a, b)}$


Sendo que o MDC é o Máximo Divisor Comum.

### 2. Verificação de Primalidade

A função **verifica se um número é primo** dividindo-o por todos os números inteiros de \(2\) até a raiz quadrada do número. Se não houver nenhum divisor exato, o número é primo.

### 3. Geração de Números Primos de Mersenne

A função **gera números primos de Mersenne** a partir da fórmula $2^n - 1$, verificando se o resultado é primo. Números primos de Mersenne têm a forma $M_n = 2^n - 1$, em que $n$ é um número primo.

## Como Rodar o Código

1. Utilize o [Venus](https://venus.kvakil.me/) para simular o código RISC-V ou qualquer outra ferramenta compatível.
   
