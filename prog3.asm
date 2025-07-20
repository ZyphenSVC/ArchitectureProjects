.data
arr: .word 10, 11, -3, -10, 50
find: .word -10

.text
.globl main

main:
la $s0, arr
lw $s1, find
lw $t0, 0($s0) # t0 = arr[0]
addi $t1, $zero, 0 # idx = 0
addi $t2, $zero, -1 # res = -1
addi $t3, $zero, 5 # len = 5
j loop

loop:
beq $t0, $s1, doneEq # if t0 == s1, j to doneEq
beq $t3, $zero, doneNeq # if t3 == 0, j to doneNeq
addi $t1, $t1, 1 # idx += 1
addi $s0, $s0, 4 # shift memory address to s0 to next int
lw $t0, 0($s0) # t0 = arr[newAddr]
addi $t3, $t3, -1 # len--
j loop


doneEq:
li $v0, 1 # print
move $a0, $t1 # print idx
syscall
j done


doneNeq:
li $v0, 1 # print
move $a0, $t2 # return -1
syscall
j done

done:
li $v0, 10 # exit
syscall
