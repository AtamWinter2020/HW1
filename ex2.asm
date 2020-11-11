.global _start

.section .text
_start:
    movq a, %rbx
    movq b, %rcx
gcd:
    cmp %rbx, %rcx
    je gcd_calculated
    ja l1
    sub %rcx, %rbx
    jmp gcd
l1:
    sub %rbx, %rcx
    jmp gcd
gcd_calculated:
    movq a, %rax
    div %rbx
    imul b, %rax
    movq %rax, (c)
