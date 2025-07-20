.data
A: .word 10, 5, 6, 15, 17, 19, 25, 30, 12, 56 # length 10
B: .word 4, 15, 16, 5, 7, 9, 15, 10, 22, 6 # length 10
C: .space 40 # Space placeholder for 4byte * 10 integers
prompt: .asciiz "Result is ["
split: .asciiz ", "
fin: .asciiz "]\n"

.text 
.globl main # Global Starting Point

# local starting point
main: 
la $s0, A # load A
la $s1, B # load B
la $s2, C # load C
addi $t4, $zero, 10 # assign 10 to t0 as A.length = 10

# loop checkpoint (gdb to confirm)
loop:
beq $t4, $zero, print # loop termination
lw $t0, 0($s0) # load A[i]
lw $t1, 0($s1) # load B[i]
sub $t2, $t0, $t1 # A[i] - B[i] arithmetic
sw $t2, 0($s2) # store into C

addi $s0, $s0, 4 # shift pointer to the next integer in array A
addi $s1, $s1, 4 # same
addi $s2, $s2, 4 # same
sub $t4, $t4, 1 # subtract 1
# jump back to loop
j loop

print:
la $t5, C # load C
addi $t4, $zero, 10 # loop setup (reusing tmp register to save space)

la $a0, prompt # load prompt
li $v0, 4 # print string
syscall

printLoop: 
lw $a0, 0($t5) # load C[i]
addi $v0, $zero, 1 # print int
syscall

addi $t5, $t5, 4 # shift pointer
sub $t4, $t4, 1 # subtract 1
beq $t4, $zero, done

la $a0, split # load comma
li $v0, 4 # print string
syscall

# jump back to printLoop
j printLoop 

done:
la $a0, fin # load fin
li $v0, 4 # print string
syscall

addi $v0, $zero, 10 # exit protocol
syscall
