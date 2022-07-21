# Função main
	# Sub rotina intermédia, usar os registos $sx para salvaguardar valores
	# Incorpora as funções presentes no mesmo diretório (strcpy, strlen, exchange e strrev)
	# Habilitar "assemble all files in directory" setting
				# Mapa de registos:
				# exit_value: $s0
				# strlen(str): $s1
	.data
	.eqv 	STR_MAX_SIZE, 30
	.eqv 	print_string, 4
	.eqv 	print_int10, 1
	.eqv 	print_char, 11
str1:	.asciiz 	"I serodatupmoC ed arutetiuqrA"
	.align 	2
str2:	.space 	31 #STR_MAX_SIZE + 1
str3: 	.asciiz 	"String too long"
	.text
	.globl main
	
main:	addiu $sp, $sp, -4 #reserva espaço na stack
	sw $ra, 0($sp) #salvaguarda $ra
	
	la $a0, str1 #$a0 = &str[0]
	jal strlen
	
	move $s1, $v0 #$s1 = strlen

if:	bgt $s1, STR_MAX_SIZE, else #if(strlen <= STR_MAX_SIZE)
	
	la $a0, str1 
	la $a1, str2
	jal strcpy
	
	move $s1
	move $a0, $v0
	li $v0, print_string
	syscall #print_String(Str2)
	
	li $a0, '\n'
	li $v0, print_string
	syscall #print_string("\n")
	
	

else:	la $a0, str3
	li $v0, print_string
	syscall #print_string("String too long")
	
	move $a0, $s1
	li $v0, print_int10
	syscall #print_int10(strlen(str1)

endif:	move $v0, $s0

	lw $ra, 0($sp)	
	addiu $sp, $sp, 4
	jr	$ra
#######################################################################################################################################		
strcpy:	li $t0, 0 #i = 0

do:	addu $t2,$t0,$a1	# $t2 = &src[i] (inicio $t2 = &src[i] + 0*4 = &src[i]
	addu $t1,$t0,$a0	# $t1 = &dst[i]
	lb  $t3, 0($t2) 	#$t3 = src[i]
	sw $t3, 0($t1)	# dst[i] = src[i]
	
	addi $t0, 1 #i++
while:	bne $t3, '\0', do #while(src[i] != '\0')
	move $v0, $a0
	jr 	$ra
#######################################################################################################################################
strrev: 	addiu $sp,$sp,-16  	# reserva espaço na stack 
  	sw $ra,0($sp)   		# guarda endereço de retorno 
  	sw $s0,4($sp)   		# guarda valor dos registos 
  	sw $s1,8($sp)   		#  $s0, $s1 e $s2 
  	sw $s2,12($sp)  		# 
  	move $s0,$a0   		# registo "callee-saved" (Própria função salvaguarda os dados)
  	move $s1,$a0   		# p1 = str 
  	move $s2,$a0   		# p2 = str 
  	
while1: lb $t0,0($s2)		# $t0 = *p2;
  	beq $t0,'\0',endw1	# while( *p2 != '\0' ) { 
  	addiu $s2,$s2,1 		# p2++;(Array de chars, incrementa ou diminui 1)
  	j while1    		# }
endw1:
  	subu $s2,$s2,1  		# p2--;(subtrai o '\0')
while2: bgeu $s1,$s2,endw2	# while(p1 < p2) { 
  	move $a0,$s1   		# $a0 = p1
  	move $a1,$s2   		# $a1 = p2
  	jal exchange  		# exchange(p1,p2) 
  	addiu $s1,$s1,1		# p1++;
  	subu $s2,$s2,1		# p2--; 
  	j while2    		# }
endw2:
  	move $v0,$s0   		# return str 
  	lw $ra,0($sp)   		# repõe endereço de retorno 
  	lw $s0,4($sp)   		# repõe o valor dos registos 
  	lw $s1,8($sp)   		#  $s0, $s1 e $s2 
  	lw $s2,12($sp)   	# 
  	addiu $sp,$sp,16		# liberta espaço da stack 
  	jr $ra    		# termina a sub-rotina 
  	
	# O argumento da função é passado em $a0 e $a1
	# Sub-rotina terminal: não devem ser usados registos $sx
	# Função do tipo void, sem retorno
				# Mapa de registos:
				# aux: $t0
				# *c1: $a0
				# *c2: $a1

exchange:	
	lb $t0,0($a0)		# char aux = *c1;
	lb $t1,0($a1)		# $t1 = *c2
	sb $t1,0($a0)		# *c1 = *c2; 
	sb $t0,0($a1)		# *c2 = aux;
#######################################################################################################################################	
strlen: 	li $t1,0 # len = 0;

while: 	lb $t0,0($a0) # while(*s++ != '\0')
 	addiu $a0,$a0,1 # *s++ = 1º -> *s; 2º -> s++ (2 intruções seguidas)
 	beq $t0,'\0',endw # {
 	addi $t1,$t1,1 # len++;
 	j while # }
 	
endw: 	move $v0,$t1 # return len;
 	jr $ra # 