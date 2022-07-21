.data
.text
.globl main
  main:li $t0, 0x19999999
       
       srl $t3, $t0, 4
       xor $t1, $t0, $t3 # num"$t1" = num"$t0" ^ (num >> 4)"$t1"
       
       srl $t n4, $t1, 2 
       xor $t1, $t1, $t4# num"$t1" = num"t1" ^ (num >> 2)"$t2"
       
       srl $t5, $t1, 1 # $t2 = $t2 >> 1
       xor $t2, $t1, $t5 # num"$t1" = num"t1" ^ (num >> 2)"$t2"
       
       jr $ra
       
      