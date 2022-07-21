# Mapa de registos:
# $t0 – value
# $t1 – bit
# $t2 - i
# $t3 - resto da divisão de i por 4
# $t4 - constante 0 (0x30 em ascii)
 	.data
str1: 	.asciiz "Introduza um numero: "
str2: 	.asciiz "\nO valor em binário e': "
 	.eqv print_string,4
 	.eqv read_int,5
 	.eqv print_char, 11
 	.eqv print_int10,1 #é melhor usar print de integers em vez de characters
	.text
 	.globl main
main: 	la $a0,str1
 	li $v0,print_string # (instrução virtual)
 	syscall # print_string(str1);
 
 	ori $v0, $0, read_int
 	syscall
 	or $t0, $v0, $0 # value=read_int();
 
 	la $a0, str2
 	li $v0, print_string
 	syscall # print_string("O valor em binário e': ");
 
 	li $t2,0 # i = 0
for: 	bge $t2,32,endfor # while(i < 32) {

 	rem $t3, $t2, 4
 	
ifRest: 	bne $t3, $0, newCont #if(i % 4 == 0)
 	li $a0, ' '
 	li $v0, print_char
 	syscall #print_char(' ')
 	  
newCont:  andi $t1, $t0, 0x80000000 #value & 0x80000000
 	srl $t1, $t1, 31 # bit = (value & 0x80000000) >> 31
 	
 	li $t4, 0x30
	add $t1, $t1, $t4 #se o bit for 1 => 0x30 +1 = 0x31 (1 em ascii)
 	
 	li $v0, print_char
 	move $a0, $t1
 	syscall # print_char(0 + bit);
           
 	sll $t0, $t0, 1 # value = value << 1;
	addi $t2, $t2, 1  # i++;
       	j for # }     
endfor: #
 	jr $ra # fim do programa 
