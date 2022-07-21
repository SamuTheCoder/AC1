	.data

	.text
	.globl main	
main:	
	jr	$ra
	
# x: $f12 -> $f20
# y: $a0  -> $s0
# i: $t0
# result: $f0
xtoy:	addiu $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $f20, 8($sp)
	s.s $f20, $f12
	mov.s $f20, $f12
	move $s0, $a0
	jal abs
	move $t1, $v0 #$t1=abs(y)
	li $t0, 0 #i=0
	l.s $f0, k1 #result = 1.0
for:	bge $t0, $t1, endfor
if:	ble $s0, 0, else
	mul.s $f0, $f0, $f20
	j	endif
else:
	div.s $f0, $f0, $f20
endif:
	addi $t0, $t0, 1 #i++
	j	for
endfor:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	l.s $f20, 8($sp)
	addiu $sp, $sp, 12
	jr $ra
	
abs: 	bge $a0, 0, endif2
	sub $a0, $0, $a0
endif2:	move $v0, $a0
	jr 	$ra
	
	
	
	