.global _start

.section .text
_start:
    xor %rax, %rax # sum
    xor %rbx, %rbx # temp value
    xor %rdi, %rdi # index
loop:
    movl arr(, %rdi, 4), %ebx
    addq %rbx, %rax
    inc %di
    cmp len, %di
    jne loop
end:
    movw len, %bx
    xor %rdx, %rdx
    div %rbx
    movq %rax, avg
