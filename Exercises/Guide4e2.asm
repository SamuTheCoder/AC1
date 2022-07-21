# Mapa de registos
# num: $t0
# p: $t1
# *p: $t2
 	.data
 	.eqv SIZE, 20
str: 	.space 21 #SIZE + 1
 	.text
 	.globl main
main: 	li 	$t0,0 #num = 0
 	la 	$a0,str # p = str;
 	li 	$v0,8
 	syscall	#read_string, (str, SIZE)
 	la	$t1,str	#p = str
while: 	# while(*p != '\0')
 	lb 	$t2, 0($t1) # $t2 = *p
 	beq 	$t2,0,endw # {
if: 	blt 	$t2,'0',endif # if(str[i] >='0' &&
 	bgt 	$t2,'9',endif # str[i] <= '9')
 	addi	$t0, $t0, 1
endif:	addiu $t1,$t1,1 # num++;
	j	while
endw: 	 # print_int10(num);
	move 	$a0, $t0
	li	$v0, 1
	syscall
 	jr 	$ra # termina o programa 