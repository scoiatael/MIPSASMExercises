.data
mem: .word 0x0A0B0C0D
h1: .asciiz "Is little-endian "
h2: .asciiz "Is big-endian "
h3: .asciiz "Is unknown"

.text
  la $a0 mem
  jal checkbe
  jal checkse
  j unke
   

checkbe: 
    lbu $t1 0($a0)
    subi $t1, $t1, 0x0A
    bne $t1, $zero, ret
    lbu $t1 1($a0)
    subi $t1, $t1, 0x0B
    bne $t1, $zero, ret
    lbu $t1 2($a0)
    subi $t1, $t1, 0x0C
    bne $t1, $zero, ret
    lbu $t1 3($a0)
    subi $t1, $t1, 0x0D
    bne $t1, $zero, ret
    j bige

checkse: 
    lbu $t1 3($a0)
    subi $t1, $t1, 0x0A
    bne $t1, $zero, ret
    lbu $t1 2($a0)
    subi $t1, $t1, 0x0B
    bne $t1, $zero, ret
    lbu $t1 1($a0)
    subi $t1, $t1, 0x0C
    bne $t1, $zero, ret
    lbu $t1 0($a0)
    subi $t1, $t1, 0x0D
    bne $t1, $zero, ret
    j smae

ret: jr $ra

bige: la $a0, h2
		li $v0, 4
		syscall
    j exit

smae: la $a0, h1
		li $v0, 4
		syscall
    j exit

unke: la $a0, h3
		li $v0, 4
		syscall
    j exit

exit: li $v0, 10
		syscall

    
