	.data
	.eqv read_int, 5
	.eqv print_string, 4
	.eqv STR_MAX_SIZE
str:	.space STR_MAX_SIZE
	.text
	.globl main
	
main:	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
do:	li $v0, read_int
	syscall #$v0 = read_int();	
	move $s0, $v0 #usar registo s para que o seu valor nao seja alterado
	
	move $a0, $s0
	li $a1, 2
	la $a2, str
	jal itoa
	
	move $a0, $v0
	li $v0, print_string
	syscall 
	
	move $a0, $s0
	li $a1, 8
	la $a2, str
	jal itoa
	
	move $a0, $v0
	li $v0, print_string
	syscall 
	
	move $a0, $s0
	li $a1, 16
	la $a2, str
	jal itoa
	
	move $a0, $v0
	li $v0, print_string
	syscall 
	
	beq $s0, 0, endDW
	
endDW:	li $v0, 0
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr	$ra
	
itoa:	addiu $sp, $sp, -8 #salvaguardar
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	
	move $s0, $a2 #char *p = s
	
do:	rem $t1, $a0, $a1 #digit = n % b
	divu $s1, $a0, $a1 #n = n / b (registo s usado pois valor nao pode ser perdido pela rotina toascii
	
	move $a0, $t1 
	jal toascii
	
	sb $v0, 0($s0)
	
endDW: