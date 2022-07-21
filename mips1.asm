	.data
str1:	.asciiz "101101"
	.eqv print_int10, 1
	.text
	.globl main
	
main:	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a0, str1
	jal atoi
	
	move $a0, $v0
	li $v0, print_int10
	syscall
	
	li $v0, 0
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr	$ra

atoi:	li $t0, 0 #digit
	li $t1, 0 #res
	
while: 	lb $t2, 0($a0)
	blt $t2, '0', endw
	bgt $t2, '9', endw
		
	sub $t0, $t2, '0'
	addiu $a0, $a0, 1
	
	mul $t1, $t1, 2  #número binário
	add $t1, $t1, $t0
	j while
	
endw:	move $v0, $t1
	jr 	$ra