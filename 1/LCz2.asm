.data
arr	:	.word 0 : 64
size:	.word 9

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
		lw $a0, 0($t1)
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
# nie zmieniaj a0, a1
# wykonaj operacje w miejscu
sol:
    addi $t0, $zero, 1
    beq $t0, $a1, tr
    beq $a1, $zero, tr
    j nietr
tr:    jr $ra # tablica 0 lub 1-elementowa posortowana! 
nietr: move $t0, $a0 #          t0 - adres pierwszego elementu
		move $t1, $a1
    sll $t1, $t1, 2
    add $t1, $t1, $a0
    subi $t1, $t1, 4 #          t1 - adres ostatniego elementu 
    lw $t2, 0($t0) #            t2 - piwot
		addi $t0, $t0, 4
loop:	bgt $t0, $t1, endSo

# przejdz po tablicy, dla kazdej liczby od a0[1] do a0[a1-1], iterator: t0:
#a  mniejszej niz t2 -> zamien ja z t2(poprzednia)
#b  wiekszej lub rownej -> zamien ja z a0[t1], dekrementuj t1 
    lw $t3, 0($t0) #             t3 - t0[0]
    blt $t2, $t3, przB
przA: subi $t4, $t0, 4 #          t4 - t0 - 1
    sw $t3, 0($t4) # zapisz w miejsce poprzedniego elementu - piwota 
		addi $t0, $t0, 4
		j loop
przB: lw $t4, 0($t1) #           t4 - t1[0]
    sw $t4, 0($t0)
    sw $t3, 0($t1)
    subi $t1, $t1, 4
    j loop
endSo: subi $t4, $t0, 4
    sw $t2, 0($t4) # piwot na swoje miejsce
# wywołania rekurencyjne : porzebujemy zapisać ra, t1 oraz a0,a1
    subi $sp $sp 16
    sw $ra, -4($sp)
    sw $t1, -8($sp)
    sw $a0, -12($sp)
    sw $a1, -16($sp)
    sub $t1, $t1, $a0
    srl $t1, $t1, 2
    move $a1, $t1
    jal sol
# pierwsza część posortowana, sp wrócił do poprzedniego stanu (hopefully)
    lw $t1, -8($sp)
    lw $a1, -16($sp)
    lw $a0, -12($sp)
    sub $a0, $t1, $a0
    srl $a0, $a0, 2 
    sub $a1, $a1, $a0
    addi $a0, $t1, 4
    subi $a1, $a1, 1
    jal sol
# druga czesc posortowana 
# stary ra na stosie
    lw $ra, -4($sp)
    addi $sp, $sp, 16
    jr $ra

