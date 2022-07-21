.data
 .text
 .globl main
main: li $t0,0x862A5C1B# load immediate, coloca um valor diretamente num registo (32 bits)
 sll $t2,$t0,4 # logical shift left
 srl $t3,$t0,4 # logical shift right
 sra $t4,$t0,4 # arithmetic shift right
 jr $ra # fim do programa
