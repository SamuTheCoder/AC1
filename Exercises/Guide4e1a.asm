# Mapa de registos
# num: $t0
# i: $t1
# str: $t2
# str+i: $t3
# str[i]: $t4
 	.data
 	.eqv SIZE,20
 	.eqv read_string, 8
 	.eqv print_int10, 1
str: 	.space 80 #space = size * 4 
 	.text
 	.globl main
main: 	la $a0, str # $a0=&str[0] (endereço da posição
 		# 0 do array, i.e., endereço
 		# inicial do array)
 	li $a1, SIZE # $a1=SIZE
 	
 	li $v0,read_string
 	syscall # read_string(str,SIZE)
 	or $t2, $0, $v0 #str = read_string
 	
 	li $t0, 0
 	li $t1, 0 # num=0; i=0;
while: 	
 	la $t2,str # $t2 = str ou &str[0] / carregar o endereço inicial do array
 	addu $t3, $t2, $t1  # $t3 = str+i ou &str[i]
 	lb $t4,0($t3) # $t4 = str[i]
 	beq $t4, '\0', endw # while(str[i] != '\0')
 
if: 	blt $t4,'0',endif # if(str[i] >= '0' &&
 	bgt $t4,'9',endif # str[i] <= '9');
 	addi $t0, $t0, 1 # num++;
endif:
 	addi $t1, $t1, 1 # i++;
 	j while # }
endw: 	li $v0, print_int10
	move $a0, $t0
	syscall # print_int10(num)
	
 	jr $ra # termina o programa 