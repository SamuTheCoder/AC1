#define SIZE 10
#define TRUE 1
#define FALSE 0
#void main(void)
#{
# static unsigned int lista[SIZE];
# int houveTroca, i, aux;
# // inserir aqui o código para leitura de valores e
# // preenchimento do array
# for(i=0; i < SIZE-1; i++)
# {
# 	lista[i] = read_int() ###ACESSO POR PONTEIROS, ATENÇÃO###
# }
# do
# {
#	 houveTroca = FALSE;
#	 for (i=0; i < SIZE-1; i++)
#	 {
#		 if (lista[i] > lista[i+1])
#		 {
#			 aux = lista[i];
#			 lista[i] = lista[i+1];
#			 lista[i+1] = aux;
#			 houveTroca = TRUE;
#		 }
#	 }
# } while (houveTroca==TRUE);
# // inserir aqui o código de impressão do conteúdo do array
# for(i=0; i < SIZE-1; i++))
# {
#	 print_int10(lista[i]) ###ACESSO INDEXADO###
# 	 print_string(";")
# }
#} 

# Bubble Sort inteiros ordem crescente
		# Mapa de registos
		# Temp1: $t3
		# houve_troca: $t4
		# i: $t5
		# lista: $t6
		# lista + i: $t7
	.data
	.eqv SIZE,10
	.eqv TRUE,1
	.eqv FALSE,0
	.eqv READ_INT,5
	.eqv PRINT_INT10,1
	.eqv PRINT_CHAR,11
lista:	.space 40		# tamanho múltiplo de 4
	.text
	.globl main
main: 	
	la $t6,lista	# Inicializar o array
			# código para leitura de valores (feito com índices)
	li $t5,0		# i = 0;
for1:	bgeu $t5,SIZE,endf1	# for(i = 0; i < SIZE; i++){
	
	li $v0,READ_INT
	syscall		# read_int();
	
	sll $t3,$t5,2	# Temp1 = i << 2  (Tornar i múltiplo de 4)
	addu $t7,$t6,$t3	# &lista[i] = &lista + (i * 4)
	sw $v0,0($t7)	# lista[i] = read_int();
	
	addiu $t5,$t5,1	# i++;
	j for1
endf1:			# }	
 	
 	la $t6,lista 	#
do: 			# do {
	li $t4,FALSE 	# houve_troca = FALSE;
	li $t5,0 		# i = 0;
	
	li $t3,SIZE		# Temp1 = SIZE
	addiu $t3,$t3,-1	# Temp1 = Temp - 1;
	
for2: 	bgeu $t5,$t3,endf2 	# for(i=0; i < SIZE-1; i++){
if: 	sll $t7,$t5,2 	# $t7 = i * 4
	addu $t7,$t7,$t6 	# $t7 (&lista[i]) = &lista[0] + i
	lw $t8,0($t7) 	# $t8 (lista[i]) = lista[i]
	lw $t9,4($t7) 	# $t9 = lista[i+1]
	bleu $t8,$t9,endif 	# if(lista[i] > lista[i+1]){
	sw $t8,4($t7) 	# lista[i+1] = $t8
	sw $t9,0($t7) 	# lista[i] = $t9
	li $t4,TRUE 	#
			# }
endif: 	 		
	addiu $t5,$t5,1	# i++;
	j for2
endf2:	 		# }
while:	beq $t4,TRUE,do	# } while(houve_troca == TRUE);
 																					
 	li $t5,0		# i = 0;	 		
 			# codigo de impressao do conteudo do array
for3:	bgeu $t5,SIZE,endf3	# for(i = 0; i < SIZE; i++){	 		
	
	sll $t3,$t5,2	# Temp1 = i << 2  (Tornar i múltiplo de 4)
	addu $t7,$t6,$t3	# &lista[i] = &lista + (i * 4)
	lw $a0,0($t7)	# lista[i] = read_int();
	
	li $v0,PRINT_INT10
	syscall		# print_int10(lista[i])
	
	li $a0,','
	li $v0,PRINT_CHAR
	syscall		# print_char(', ');
	
	addiu $t5,$t5,1	# i++;
	j for3
endf3:
	jr $ra 		# termina o programa