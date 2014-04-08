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

sol: li $t3,  0xEF800000
    and $t0, $a0, $t3
    srl $t0, $t0, 23
    add $t0, $a1, $t0
    li $t1, 0xFF
loopS: blt $t0, $t1, endS 
    srl $t0, $t0, 1
    j loopS
endS: nor $t3, $zero, $t3 
    sll $t0, $t0, 23
    and $a0, $a0, $t3 
    or $v0, $a0, $t0
    jr $ra
