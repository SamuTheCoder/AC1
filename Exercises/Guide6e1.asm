	.data #0x10010000
	 
str1: 	.asciiz "Array" 	#10010000
str2:	.asciiz "de"    	#10010000
str3:	.asciiz "Ponteiros" #0x10010000

# 20 + 12
array: 	.word str1, str2, str3 #0x1001000, 0x10010006, 0x1001009	
	.eqv SIZE, 3		
	.text
	.globl main 
	
main: 	li 	$t0, 0 #i = 0
for:	bge 	$t0, SIZE, endfor
		
	la 	$t1, array 	#$t1=&array[0]
	sll 	$t2, $t0, 2
	addu 	$t1, $t1, $t2 	#$t1 = &array[i]
	
	lw 	$a0, 0($t1)	#$a0 = array[i]
	li 	$v0, 4
	syscall
	
	li 	$a0, '\n'
	li 	$v0, 11
	syscall
	
	addi 	$t0, $t0, 1	#i++	
	j 	for
	
endfor:
	la 	$t1, array
	lw	$t1, 8($t1)	#$t1 = &array[2]
	lb 	$a0, 5($t1)	#$t2 = array[2][5]
	li 	$v0, 11
	syscall
	
	jr	$ra
