.data
h1: .asciiz "a: "
h2: .asciiz " b: "
h3: .asciiz " ret: "
h4: .asciiz " a+b: "
h5: .asciiz " a-b: "

.text
		li $v0, 5
		syscall
		move $t0, $v0

		la $a0, h1
		li $v0, 4
		syscall
    
    srl $a0, $t0, 16
    jal ext
    li $v0, 1
    syscall

		la $a0, h2
		li $v0, 4
		syscall

    andi $a0, $t0, 0xFFFF
    jal ext
    li $v0, 1
    syscall

    move $a0, $t0
		jal sol
		move $t0, $v0

		la $a0, h3
		li $v0, 4
		syscall

    move $a0, $t0
    li $v0, 1 
    syscall

		la $a0, h4
		li $v0, 4
		syscall
    
    srl $a0, $t0, 16
    jal ext
    li $v0, 1
    syscall

		la $a0, h5
		li $v0, 4
		syscall

    andi $a0, $t0, 0xFFFF
    jal ext
    li $v0, 1
    syscall

		li $v0, 10
		syscall

sol: andi $t1, $a0, 0xFFFF
    srl $t0, $a0, 16
    subi $sp, $sp, 4
    move $t6, $ra

    move $a0, $t0
    jal ext
    move $t0, $a0

    move $a0, $t1
    jal ext
    move $t1, $a0

    add $t2, $t0, $t1
    sub $a0, $t0, $t1
    andi $a0, $a0, 0xFFFF
    sll $t2, $t2, 16
    or $v0, $a0, $t2
    jr $t6
    
ext: andi $t7, $a0, 0x8000
    beq $t7, $zero, endE
    ori $t7, $zero, 0xFFFF
    sll $t7, $t7, 16
    or $a0, $a0, $t7
endE: jr $ra
