.data
arr	:	.word 0 : 3
size:	.word 3

.text
		la $t1, size
		lw $t1, 0($t1)
    sll $t1, $t1, 2
		la $t0, arr

    li, $v0, 8
    move $a0, $t0
    move $a1, $t1
    syscall

    jal sol

    li, $v0, 4
    syscall

    li, $v0, 10
    syscall


sol: move $t7, $ra 
    move $t0, $a1
    add $t0, $t0, $a0
loop: 
    beq $t0, $t1, end
    lbu $t1, 0($t0)
    jal conv
    sb $t1, 0($t0)
    lbu $t1, 1($t0)
    jal conv
    sb $t1, 1($t0)
    lbu $t1, 2($t0)
    jal conv
    sb $t1, 2($t0)
    lbu $t1, 3($t0)
    jal conv
    sb $t1, 3($t0)
    subi $t1, $t1, 4
    j loop
end: jr $t7

conv: li $t2, 32
    beq $t1, $t2, retC
    li $t2, 90
    bgt $t1, $t2, upp
    addi $t1, $t1, 32
    j retC
upp: subi $t1, $t1, 32
retC: jr $ra
