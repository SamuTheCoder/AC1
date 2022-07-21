	.data
str:	.asciiz "Arquitetura de Computadores I" 
	.text
	.globl main
main:	addiu $sp, $sp, -4 #criar espaço na stack
	sw $ra, 0($sp) #salvaguardar $sp
	
	la $a0, str #$a0 = &str[0]
	jal strlen #strlen(str)
	
	move $a0, $v0 #$a0 = strlen(str)
	li $v0, 1 #$v0 = print_int10(strlen(str))
	syscall
	
	lw $ra, 0($sp) #recuperar $ra
	addiu $sp, $sp, 4 #libertar espaço na stack
	jr $ra
	
strlen: 	li $t1,0 # len = 0;
while: 	lb $t0,0($a0) # while(*s++ != '\0')
 	addiu $a0,$a0,1 #
 	beq $t0,'\0',endw # {
 	addi $t1,$t1,1 # len++;
 	j while# }
endw: 	move $v0,$t1 # return len;
 	jr $ra # 