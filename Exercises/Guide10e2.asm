	.data
	.eqv print_double, 3
	.eqv read_double, 7
	.eqv print_string, 4
	.text
	.globl main
main:	addiu $sp, $sp, -4 #reserva espaço na stack
	sw $ra, 0($sp) #guardar valor de $ra em memória externa
	
	la $a0, str1
	li $v0, print_string
	syscall #print_string(str1)
	
	li $v0, read_double
	syscall 
	
	mov.d $f12, $f0 #$f12 = raiz
	jal sqrt
	
	la $a0, str2
	li $v0, print_string
	syscall #print_strin(str2)
	
	mov.d $f12, $f0 #$f12 = sqrt(raiz)
	li $v0, print_double
	syscall
	
	li $v0, 0
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr	 $ra