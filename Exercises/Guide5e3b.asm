#define SIZE 10
#define TRUE 1
#define FALSE 0
#void main(void)
#{
# static int lista[SIZE];
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
# Mapa de registos
# ...
# houve_troca: $t4
# i: $t5
# lista: $t6
# lista + i: $t7
 	.data
 	.eqv FALSE,0
 	.eqv TRUE,1
 	.eqv read_int, 5
 	.eqv print_int10, 1
 	.eqv SIZE, 10
lista:	.space 40
 	.text
 	.globl main
main: 	 # código para leitura de valores
 	la 	$t6,lista #
 	li 	$t0, 9 #SIZE - 1
 	
 	li 	$t5, 0 # i = 0

forRead: 	bge 	$t5, SIZE, endfRead # i < SIZE
	
	li 	$v0, read_int
	syscall
	
	sll	$t3, $t5, 2 # i * 4
	addu 	$t7, $t6, $t3 # &lista[i] = $lista[0] +  i * 4
	sw 	$v0, 0($t7) # lista[i] = read_int()
	
	addiu	$t5, $t5, 1 #i++
	j	forRead

endfRead:	la	$t6, lista # $t6 = &lista[i]

do: # do {
 	li $t4,FALSE # houve_troca = FALSE;
 	li $t5,0 # i = 0;
 	
for: 	bge 	$t5, $t0, endfor  # while(i < SIZE-1){
if: 	sll 	$t7, $t5, 2 # $t7 = i * 4
 	addu 	$t7, $t7, $t6  # $t7 = &lista[i]
 	lw 	$t8, 0($t7) # $t8 = lista[i]
 	lw 	$t9, 4($t7) # $t9 = lista[i+1]
 	ble 	$t8, $t9, endif # if(lista[i] > lista[i+1]){
 	sw  	$t8, 4($t7) # lista[i+1] = $t8
 	sw 	$t9, 0($t7) # lista[i] = $t9
 	li 	$t4, TRUE  # 	

endif: 	addiu 	$t5, $t5, 1 # i++;
 	j	for # }
endfor: 	
while:	beq 	$t4, TRUE, do # while(houve_troca == TRUE)

	li 	$t5, 0 	#i = 0

forPrint: bge 	$t5, SIZE, endfPrint  # i < SIZE-1
 	
 	sll 	$t3, $t5, 2 #i * 4
 	addu 	$t7, $t3, $t6 #&lista[i] = &lista + i * 4
  	lw	$a0, 0($t7) # $a0 = *(lista[i])
  	
  	li 	$v0, print_int10
  	syscall	#print_int10(lista[i])
  	
  	li 	$a0, ';'
  	li 	$v0, 11
  	syscall 	#print_char(";")
  	
  	j	forPrint
endfPrint:	# 
 	jr $ra # termina o programa 
