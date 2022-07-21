.data
.text
.globl main

main: li $t1, 4
      li $t0, 0x11111110
      andi $t3, $t1, 0x00000003
      
      jr 		$ra