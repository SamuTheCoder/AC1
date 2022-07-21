# $t1: p
# $t2: pultimo

	.data

str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "Ponteiros"

array: 	.word str1, str2, str3
	.eqv SIZE, 3 #3 * 4
	.text
	.globl main
	
main:
	la $t1,array 		# $t1 = p = &array[0] = array
 	li $t0,SIZE 		# $t0 = SIZE
	sll $t0,$t0,2 		#
 	addu $t2, $t1, $t0 	# $t2 = pultimo = array + SIZE 
 	
for:	bge	$t1, $t2, endfor

	lw 	$a0, 0($t1) 	#$a0 = *p (*p = array[0, 1 ou 2])
	li 	$v0, 4		#print_string(*p)
	syscall
	
	li 	$a0, '\n' 	#print_char("\n")
	li 	$v0, 11
	syscall
	
	addiu	$t1, $t1, 4	#adicionar 4 a p porque estamos a processar words

	j 	for
	
endfor:

	jr	$ra
