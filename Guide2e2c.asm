.data
.text
.globl main
main: li $t0, 0x11111111
      srl $t2, $t0, 1 #logical shift right cause the value is unsigned
      xor $t1, $t0, $t2 #gray = bin ^ (bin >> 1)
      jr $ra