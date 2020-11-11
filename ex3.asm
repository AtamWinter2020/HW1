.global _start

.section .text
_start:
    xor %rax, %rax #sum
    xor %rcx, %rcx #index
    xor %rsp, %rsp #temporary value for current array element
    movq $arr, %rdi #adress of array in rdi
    movw len, %bx #len
loop:
    movl (%rdi, %rbx, 4), %esp
    addq %rsp, %rax
    dec %bx
    cmp $0, %bx
    jne loop
end:
    movw len, %bx
    xor %rdx, %rdx
    div %rbx
    movq %rax, avg
    
