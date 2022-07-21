	.eqv SIZE, 20
	.data #0x10010000
str:	.space 21 #SIZE + 1
	.text
	.globl main
#mapa de registos
#num: $t0
#i: $t1
#str: $t2
#str+i: $t3
#str[i]: $t4
main:	la	$a0, str # $a0 = &str[0]
	li 	$a1, 20	
	li 	$v0, 8
	syscall # read_string(str, SIZE)
	li 	$t0, 0 #num = 0
	li 	$t1, 0 #i = 0
while:	la	$t2, str
	addu	$t3, $t2, $t1 # $t3 = &str[i]
	lb	$t4, 0($t3) # $t4 = &str[i]
	beq	$t4, '\0', endw
if: 	blt	$t4, '0', endif
	bgt	$t4, '9', endif
endif: 	addi 	$t1, $t1, 1 #i++	
	j	while
endw: 	move	$a0, $t0
	li	$v0, 1
         	syscall
         	jr	$ra 
         

	
	
	
	
	
	