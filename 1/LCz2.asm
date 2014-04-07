.data
arr	:	.word 0 : 3
size:	.word 3

h1	:	.asciiz "[ "
h2	:	.asciiz ", "
h3	:	.asciiz "]\n"

.text
		la $t0, size
		lw $t0, 0($t0)
		la $t1, arr
lo:		beq $t0, $zero, call
		li $v0, 5
		syscall
		sw $v0 0($t1)
		addi $t1 $t1 4
		subi $t0 $t0 1
		j lo
call:	la $a1, size
		lw $a1, 0($a1)
		la $a0, arr
		jal sol
		la $a0, h1
		li $v0, 4
		syscall

		la $t0, size
		lw $t0, 0($t0)
		la $t1, arr
printn:	beq $t0, $zero, endP
		lw $a0, $0(t1)
		li $v0, 1
		syscall
		la $a0, h2
		li $v0, 4
		syscall
		addi $t1 $t1 4
		subi $t0 $t0 1
		j printn
endP:	la $a0, h3
		li $v0, 4
		syscall
		li $v0, 10
		syscall

# a0 - adres tablicy a1 - rozmiar
# wywolania rekurencyjne : zrzuc ra na stos
sol:	move $t0, $zero
		move $t1, $zero
		move $t2, $a0
		move $t3, $a1
		move $t5, $ra
loop:	beq $t3, $zero, endSo
		lw $t4, 0($t2)
		add $t0, $t0, $t4

# wywołaj max: nie korzysta on z rejestrów t0-t5 
		move $a0, $t1
		move $a1, $t4
		jal max
		move $t1, $v0

		subi $t3, $t3, 1
		addi $t2, $t2, 4
		j loop
endSo:	move $v0, $t0
		move $v1, $t1		
# stary ra jest w t5
		jr $t5

# w v0 zapisze max z a0 i a1
max :	blt $a0, $a1, pmn
# a0 > a1
		move $v0, $a0
		j endM
# a0 <= a1
pmn:	move $v0, $a1
endM:	jr $ra
