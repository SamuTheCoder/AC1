	.data
	.text
	.globl main
	
main:





strcpy: li $t0, 0 #i = 0

do:	addiu $t1, $a0, $t0 #$t1 = &dst[i]
	addiu $t2, $a1, $t0 #$t2 = &src[i]
	lb $t3, 0($t2) #$t3 = src[i]
	sb $t3, 0($t1) #dst[i] = src[i] 
	
while	addiu $t2, $t2, 1 #$t2 = &src[i++]
	lb $t4, 0($t2) #$t4 = src[i++]
	beq $t4, '\0', endDW #while(src[i++] != '\0');
	
	j	do
endDW:	move $v0, $s0