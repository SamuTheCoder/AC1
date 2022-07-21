#Mapa de Registos
#$t0: i
#$t1: v
#$t2: &(val[0])
#$t3: val[i+size/2]
#Temp1: $t4
#$t5: val[i++]

	.data
	.eqv print_int10, 1
	.eqv print_char, 11
	.eqv print_string, 4
str1: 	.asciiz "Result is: "
	.eqv SIZE, 8
	.eqv 
val:	.word 8,4,15,-1987,327,-9,27,16
	.text
	.globl main
	
main: 	li $t0, 0
	la $t2, val #$t2= &(val[0])
	
do1:	
	sll $t1, $t0, 2 #$t1 = i * 4
	addu $t1, $t1, $t2 #$t1 = &(val[i])
	lw $t1, 0($t1) #v = val[i]
	
	sll $t3, $t0, 2 #$t2 = i * 4
	addu $t3, $t2, $t3 #$t3 = &(val[i])
	addiu $t3, $t3, 4 #$t3 = &(val[i+SIZE/2])
	lw $t3, 0($t3) #$t3 = val[i+SIZE/2]
	
	move $t4, $t1 #Temp1 stores val[i]
	move $t1, $t3 #val[i] = val[i+SIZE/2]
	move $t3, $t4 #val[i+SIZE/2] = val[i]
	
	addi $t0, $t0, 1 #i++
while1:   bge $t0, 4, endDW1
	j	do1

endDW1:
	la $a0, str1
	li $v0, print_string
	syscall #print_String(str1)
	
	li $t0, 0
	
do2:	addi $t0, $t0, 1 #i++
	sll $t5, $t0, 2 #$t5 = i * 4
	addu $t5, $t5, $t2 #$t5 = &(val[i++])
	lw $t5, 0($t5) #$t5 = val[i++]
	
	move $a0, $t5
	li $v0, print_int10
	syscall #print_int10(val[i++])
	
	li $a0, ','
	li $v0, print_char
	syscall #print_Char(",")

while2:	bge $t0, SIZE, endDW2 #while( i < SIZE)
	j 	do2

endDW2:
	jr	$ra	