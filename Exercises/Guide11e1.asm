	.data	
str1:	.asciiz "\nN. Mec: "
str2:	.asciiz "\nNome: "
str3:	.asciiz "\nNota: "
	.align 2
stg:	.word	72343
	.asciiz "Napoleao"
	.space 9	
	.asciiz "Bonaparte"
	.space 5
	.float 5.1
	
	.text
	.globl main
main:	
	la $a0, str1
	li $v0, 4
	syscall
	
	la $t0, stg #$t0 = &stg
	
	li $v0, 36
	lw $a0, 0($t0)
	syscall
	
	la $a0, str2
	li $v0, 4
	syscall
	
	addiu $a0, $t0, 22 # $a0 = &stg.last_name
	li $v0, 4
	syscall #print_string(stg.last_name)
	
	la $a0, str3
	li $v0, 4
	syscall
	
	li $v0, 2
	l.s $f12, 40($t0)
	syscall
	
	jr 	$ra

	
		

	