#Mapa de registos
#$t0: p
#$t1: *p

	.data
	.eqv print_string,4
	.eqv read_string,8
	.eqv print_char,11
	.eqv SIZE, 20
str1: 	.asciiz "Introduza uma string: "
str:	.space 21 #SIZE * 4
	.text
	.globl main
	
main:	la $a0, str1
	li $v0, print_string
	syscall #print_string(str1)
	
	li $v0, read_string
	la $a0, str
	li $a1, SIZE
	syscall #read_string(str, SIZE)
	
	move $t0, $a0 #p = str = &str[0]
	
while:	lb $t1, 0($t0) #$t1 = *p
	
	beq $t1,'\0',endw 
	
	sub $t1, $t1, 0x61
	addi $t1, $t1, 0x41
		
	addi $t0, $t0, 1 #p++
	
	j	while
endw:	li $v0, print_string
	la $a0, str
	syscall #print_char(array[i][j])
	
	jr 	$ra