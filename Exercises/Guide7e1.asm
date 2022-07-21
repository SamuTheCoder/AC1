# O argumento da fun��o � passado em $a0
# O resultado � devolvido em $v0
# Sub-rotina terminal: n�o devem ser usados registos $sx
#Mapa de registos:
#$a0: s 
#$t0: *s
#$t1: len
#$v0: return
	.data
str: 	.asciiz "Uma string qualquer"
	.text
	.globl main
	
main:	addiu $sp,$sp,-4

	la $a0,str #$a0, &str[0]
	jal strlen
	
	move $a0,$v0
	li $v0,1
	syscall
	
	li $v0,0 #return 0
	lw $ra, 0($sp)
	addiu $sp,$sp,4

	jr 	$ra	
	
strlen: 	li $t1,0 # len = 0;

while: 	lb $t0,0($a0) # while(*s++ != '\0')
 	addiu $a0,$a0,1 # *s++ = 1� -> *s; 2� -> s++ (2 intru��es seguidas)
 	beq $t0,'\0',endw # {
 	addi $t1,$t1,1 # len++;
 	j while # }
 	
endw: 	move $v0,$t1 # return len;
 	jr $ra # 