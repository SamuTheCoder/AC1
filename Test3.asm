#Mapa de Registos
#n_even: $t0
#n_odd: $t1
#p1: $t2
#p2: $t3
#for1Cond: $t4
#*p1: $t5
#*p2: $t6
#rem: $t7
#p2++: $t8
#b+n_odd: $t9
	.data
	.eqv read_int, 5
	.eqv print_int10, 1
	.eqv N, 5
a:	.space 20
	.align 2
b:	.space 20
	.align 2
	.text
	.globl main
	
main:	li $t0, 0 #neven = 0
	li $t1, 0 #nodd = 0
	
	la $t2, a #p1 = &a[0]
	la $t4, a
	addi $t4, $t4, 20 #$t4 = &a[0] + N (N * 4 porque estamos a processar words)

for1:	bgeu $t2, $t4, endf1 #for1
	
	li $v0, read_int
	syscall 
	move $t5, $v0 #$t5 = read_int()
	sw $t5, 0($t2)  # *p1 = read_int() (stores *p1 in the right address p1) 
	
	addi $t2, $t2, 4 #p1++
	j	for1
	
endf1:	la $t2, a #p1 = &a[0]
	la $t3, b #p2 = &b[0]

for2:	bgeu $t2, $t4, endf2 #for1
	
	lw $t5, 0($t2) #$t5 = *p1
	rem $t7, $t5, 2 #$t7 = *p1 % 2
if:	beq $t7, 0, else #if((*p1 % 2) != 0)
	
	sw $t5, 0($t3) #stores *p1 in the address p2
	
	addi $t1, $t1, 1 #n_odd++
	addiu $t2, $t2, 4 #p1++
	addiu $t3, $t3, 4 #p2++
	j	for2
	
else:	addi $t0, $t0, 1 #n_even++
	addiu $t2, $t2, 4 #p1++
	addiu $t3, $t3, 4 #p2++
	
	j	for2
endf2:	la $t3, b #p2 = &b[0]
	sll $t1, $t1, 2 #n_odd * 4
	addu $t9,$t3,$t1 #$t9 = b + n_odd
	
for3:	bge $t3, $t9, endf3 #for(p2 = b, p2 < b + n_odd; p2++)
	
	lw $t6, 0($t3) #$t6 = *p2
	move $a0, $t6 
	li $v0, print_int10
	syscall #print_int10(*p2)
	
	li    $v0,11
    	li    $a0,';'
    	syscall        # print_char(';')
	
	addiu $t3, $t3, 4 #p2++
	j	for3
endf3:
	jr 	$ra
