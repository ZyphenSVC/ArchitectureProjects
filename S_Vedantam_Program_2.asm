.data
arr: .word 10, 3, 45, 90, 12 # length 5
prompt: .asciiz "Largest in given array is" # no space " " in the original code.
fin: .asciiz "\n"

.text 
.globl main # Global Starting Point

# local starting point
main:
la $s0, arr # load arr
lw $t0, 0($s0) # max = arr[0]
addi $t1, $zero, 5 # assign 5 to t0 as arr.length = 5
# addi $t2, $zero, 1 # i = 1

loop:
beq $t1, $zero, print # loop termination
sub $t1, $t1, 1 # subtract 1
lw $t2, 0($s0) # load arr[i]
slt $t3, $t0, $t2 # Check is max < arr[i]; 1 if true, 0 false.
beq $t3, $zero, continue # if true, continue, else false
move $t0, $t2 # input t2 into t0.
j continue

continue:
addi $s0, $s0, 4 # move forward
j loop

print:
la $t4, arr # load arr from scratch
la $a0, prompt # load prompt
li $v0, 4 # print string
syscall

move $a0, $t0 # input max
addi $v0, $zero, 1 # print int
syscall

done:
la $a0, fin # load fin
li $v0, 4 # print string
syscall

addi $v0, $zero, 10 # exit protocol
syscall
