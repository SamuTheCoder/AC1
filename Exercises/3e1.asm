	.text
	.globl main
#soma: $t0
#value: $t1
#f: $t2
main:	li 	$t2, 0
	li 	$t0, 0
for: 	bge 	$t2, 5, endfor #i < 5
	
	la $a0, str1
	li $v0, READ_INT
	syscall
	move $t1, $v0
if: 	ble 	$t1, 0, else
	add $t0, $t0, $t1
	j	endif
else:
	la	$a0, str2
	li	$v0, PRINT_STRING
	syscall
endif:
	addi	$t2, $t2, 1
	j	for
endfor:		
	la	$a0, str3
	li 	$v0, PRINT_STRING
	syscall			#print_string(str3)
	
	move 	$a0, $t0
	li	$v0, PRINT_INT10
	syscall			#print_int10(soma)
	
	jr	$ra
	
	
	
	
	
	
	
	
	
	