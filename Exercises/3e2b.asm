# Mapa de registos:
# $t0 – value
# $t1 – bit
# $t2 - i
 .data
str1: 	.asciiz "Introduza um numero: "
str2: 	.asciiz "\nO valor em binário e': "
 	.eqv print_string,4
 	.eqv read_int,...
 	.eqv print_char,... 
 .text
 .globl main
main: 	la $a0,str1
 	li $v0,print_string # (instrução virtual)
 	syscall # print_string(str1);
 	la $a1 # value=read_int();
 	 # print_string("...");
 	li $t2,0 # i = 0
for: 	bge $t2,32,endfor # while(i < 32) {
 	# (instrução virtual)
 	 # if(bit != 0)
 		 # print_char('1');
else: 	la $a2, str2# else
 	li $v1, print_string # print_char('0');
 	sll $t0, $t0, 1# value = value << 1;
 	addi $t2, $t2, 0x00000001# i++;
 	j for # }
endfor: 
	jr 	$ra
 	jr $ra # fim do programa 