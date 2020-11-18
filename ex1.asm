.global _start

.section .text
_start:  
  movq %rsp, %rbp #for correct debugging
  movq num, %rdx
  movl %edx, %ecx
  andl $1, %ecx
loop:
  cmpq $0, %rdx
  jz end
  shrq $1, %rdx
  test $1, %rdx
  jz loop
  addl $1, %ecx
  jmp loop
  
end:
  movq %rcx, (countBit)
