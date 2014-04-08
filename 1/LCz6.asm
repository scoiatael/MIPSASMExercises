.data
h1: .asciiz " a*2^b: "

.text
		li $v0, 5
		syscall
		move $t0, $v0

		li $v0, 5
		syscall
		move $t1, $v0

		la $a0, h1
		li $v0, 4
		syscall
    
    move $a0, $t0
    move $a1, $t1
		jal sol

		move $a0, $v0
    li $v0, 1
    syscall

		li $v0, 10
		syscall

sol: li $t0,  0xEF800000
    and $t1, $a0, $t0
    srl $t1, $t1, 23
    and $t2, $a1, $t0
    srl $t2, $t2, 23
    add $t1, $t1, $t2
    li $t2, 0xFF
loopS: blt $t1, $t2, endS 
    srl $t1, $t1, 1
    j loopS
endS: sll $t7, $t1, 23
# t7 now has exponent ( = exp_1 + exp_2)

    li $t0,  0x007FFFFF
    and $t1, $a0, $t0
    and $t2, $a1, $t0
    mult $t3, $t1, $t2
    srl $t3, $t3, 2
    add $t3, $t3, $t2
    add $t3, $t3, $t1
    addi $t3, $t3, 0x00800000
loopSD: blt $t3, $t0, endSD
    srl $t3, $t3, 1
    j loopSD
endSD: move $t6, $t3
# now t6 has mantissa ( = (1.0 + mant_1) * (1.0 + mant_2) = 1.0 + mant_1 + mant_2 + mant_1 * mant_2 )

    jr $ra
