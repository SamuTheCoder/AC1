	.data
float_:	.float 2.59375
zero:	.float 0.0
	.text
	.globl main
	
# res: $f0
# val: $t0
main:
do: 	li $v0,5
	syscall
	move $t0,$v0

	mtc1 $t0,$f0 # $f0 <= $t0
	cvt.s.w $f0,$f0 #$f0 = (float) val
	
	l.s  $f2,float_ #f2 = 2.59375
	
	mul.s $f0,$f0,$f2 #res=(float)val*2.5--
	
	li $v0,2
	mov.s $f12,$f0
	syscall #print_float(res)
	
	l.s $f2,zero # $f0 = 0.0
	c.eq.s $f0,$f2
	bc1f do
	
	li $v0,0
	jr	$ra
	