.data
h1: .asciiz "s number of ones: "

.text
		li $v0, 5
		syscall
		move $a0, $v0
    li $v0, 1
    syscall
		jal sol
		move $t0, $v0
		la $a0, h1
		li $v0, 4
		syscall
		move $a0, $t0
		li $v0, 1
		syscall
		li $v0, 10
		syscall

sol: move $v0, $zero
sol1: beq $a0, $zero, endS
    andi $t0, $a0, 1
    srl $a0, $a0, 1	
    beq $t0, $zero, sol1
    addi $v0, $v0, 1
    j sol1
endS: jr $ra
    
