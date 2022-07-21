# Mapa de registos
# num: $t0
# p: $t1
# *p: $t2
 	.data
 	.eqv SIZE, 20
 	.eqv read_string, 8
 	.eqv print_int10, 1
str:	.space 80
 	.text
 	.globl main
main: ... # ...
 	la $t1,str # p = str; iniciar o ponteiro com o endereço do primeiro elemento do array
 	
	la $a0,str			# $a0 = buf (endereço da posição inicial do array)
	li $a1,SIZE			# $a1 = tamanho do array
	li $v0, read_string	# valor da operação
	syscall				# num = read_string(str,SIZE)
	
while: 	# while(*p != '\0')
 	lb $t2, 0($t1) # *p = str[i]
 	beq $t2,0,endw # {
 	blt $t2,'0',endif # if(str[i] >='0' &&
 	bgt $t2,'9',endif # str[i] <= '9')
 	addi $t0, $t0, 1 # num++;
endif:
 	addiu $t1, $t1, 1 # p++;
 	j while # }
 	
endw: 	move $a0, $t0 
	li $v0, print_int10
	syscall # print_int10(num);
	
 	jr $ra # termina o programa 
