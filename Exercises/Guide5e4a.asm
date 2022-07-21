# Mapa de registos
# *p: $t1
# *(p + 1): $t2
# aux: $t3
# houve_troca: $t4
# p: $t5
# pUltimo: $t6
 	.data
 	.eqv TRUE, 1
 	.eqv FALSE, 0
 	.eqv SIZE, 10
 	.eqv print_string, 4
 	.eqv read_int 5
 	.eqv print_int10, 1
 	.eqv print_char, 11
lista:	.word 10
 	.text
 	.globl main
 	
main: 	
 	la $t5,lista # p = &lista[0]
 	li $t6,SIZE #
 	
 	move $t0, $t6 #$t0 = SIZE
 	sll $t0, $t0, 2 # SIZE * 4
 	addu $t7, $t5, $t0 #$t7 = &lista[0] + SIZE
 	
 	subu $t6,$t6,1 # pultimo = SIZE – 1
 	sll $t6,$t6, 2 # pultimo = (SIZE – 1) * 4
 	addu $t6,$t6,$t5 # pultimo = &lista[0] + (SIZE – 1) * 4
 	
for1:	bge $t5, $t7, endfor1

	li	$v0,read_int
	syscall #read_int()
	
	sw $v0, 0($t5) #lista[i] = *p
	addiu $t5, $t5, 4 #p++
	
	j	for1
endfor1: 	la $t5, lista #p = &lista[0]
 	
do: 	li $t4, FALSE # do {
 	
for2:	bge $t5, $t6, endfor2 # p >= pultimo => sai do ciclo
	
	lw  $t1, 0($t5) # $t1 = *p
	lw  $t2, 4($t5) # $t2 = *(p+1)
		
if:	ble $t1, $t2, endif # if(*p > *(p+1))
	
	move $t3, $t1 # aux = *p
	move $t1, $t2 # *p = *(p+1)
	move $t2, $t3 #*(p+1) = aux
	
	sw $t1, 0($t5) #stores the new value of *p in the respective address
	sw $t2, 4($t5) #stores the new value of *(p+1) in the respective address
	
	li $t4, TRUE #houveTroca = TRUE 	

endif:	addiu $t5, $t5, 4 #p++
	j 	for2

endfor2:  la  $t5, lista #p = &lista[0]
while:	beq $t4, TRUE, do #} while (houveTroca == TRUE)

for3:	bge $t5, $t7, endfor3 # for(p < &lista[0] + SIZE)
	
	lw  $a0, 0($t5) #$a0 = lista[i] or $a0 = *p
	li $v0, print_int10
	syscall
	
	li $a0, ','
	li $v0, print_char
	syscall #print_char(",")
	
	addiu $t5, $t5, 4 # p++
	j	for3
endfor3:
	jr	$ra