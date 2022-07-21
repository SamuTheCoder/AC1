#Mapa de registos
#val: $t0
#n: $t1
#min: $t2
#max $t3

	.data
	.eqv print_string, 4
	.eqv print_char, 11
	.eqv print_int10, 1
	.eqv read_int, 5
str1:      .asciiz "Digite ate 20 inteiros(zero para terminar):"
str2:	.asciiz "Maximo e minimo sao:"
	.text
	.globl main
	
main: 	la $a0, str1
	li $v0, print_string
	syscall #print_String(str1)
	
	li $t1, 0
	ori $t2, $0, 0x7FFFFFFF
	ori $t3, $0, 0x80000000
	
do:
	li $v0, read_int
	syscall #$v0 = read_int()
	move $t0, $v0 #$t0 = read_int()
	
if1:	beq $t0, 0, endif #if(val !=  0)
	
if2:	ble $t0, $t3, if3 #if(val > max)

	move $t3, $t0
if3:	bge $t0, $t2, endif #if(val < min)
	
	move $t2, $t0
endif:	addi $t1, $t1, 1 #n++

while: 	bge $t1, 20, endDW # while(( n < 20)
	beq $t0, 0, endDW # && (val != 0))
	j 	do #jumps to do
endDW:
	la $a0, str2
	li $v0, print_string
	syscall
	
	move $a0, $t3
	li $v0, print_int10
	syscall
	
	li $a0, ':'
	li $v0, print_char
	syscall
	
	move $a0, $t2
	li $v0, print_int10
	syscall
	
	jr 	$ra

