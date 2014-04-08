.data
h1: .asciiz " a*b: "
h2: .asciiz " Error: mantissa overflow\n"

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
    subi $t7, $t1, 127 # bias
# t7 now has exponent ( = exp_1 + exp_2 - bias)

    li $t0,  0x007FFFFF
    and $t1, $a0, $t0
    addi $t1, $t1, 0x00800000
    and $t2, $a1, $t0
    addi $t2, $t2, 0x00800000

    mult $t1, $t2
    mflo $t3
    srl $t3, $t3, 22
    mfhi $t4
    sll $t4, $t4, 9
    or $t3, $t3, $t4
    ori $t0, $t0, 0x00800000
loopSD: ble $t3, $t0, endSD
    srl $t3, $t3, 1
    addi $t7, $t7, 1
    j loopSD
endSD: andi $t6, $t3, 0x007FFFFF
# now t6 has mantissa ( = (0x00800000 + mant_1) * (0x0080000 + mant_2) >> 22 = 

    li $t0, 0x80000000
    and $t1, $a0, $t0
    and $t2, $a1, $t0
    xor $v0, $t1, $t2
# v0 has sign

    li $t0, 0xFF
    blt $t0, $t7, mantissaOverflow
    sll $t7, $t7, 23

    or $v0, $v0, $t7
    or $v0, $v0, $t6
    jr $ra

mantissaOverflow:
		la $a0, h2
		li $v0, 4
		syscall

		li $v0, 10
		syscall
