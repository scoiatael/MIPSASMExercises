.data
h1	:	.asciiz "th fib is: "

.text
		li $v0, 5
		syscall
    move $a0, $v0
 
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

# w a0 liczba do policzenia
# na stos odlozyc: ra, ta liczbe, wynik wywolania rekurencyjnego #1

sol:
    beq $a0, $zero, tryw
    addi $t0, $zero, 1
    beq $a0, $t0, tryw
    j nietryw
tryw: addi $v0, $zero, 1
    jr $ra
nietryw: 
    subi $sp, $sp, 8
    sw $ra, -4($sp)
    sw $a0, -8($sp)
    subi $a0, $a0, 2
    jal sol
    lw $a0, -8($sp)
    sw $v0, -8($sp)
    subi $a0, $a0, 1
    jal sol
    lw $t0, -8($sp)
    add $v0, $v0, $t0
    lw $ra, -4($sp)	
    addi $sp, $sp, 8
    jr $ra
