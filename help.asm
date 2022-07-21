	.data
str:	.asciiz "arquitetura de computadores"
arr:	.byte str
	.text
	.globl main
	
main: 

      la $t0,arr
      lb $a0,0($t0)
      li $v0,11
      syscall
      