.global _start

.section .text
_start:
    movq $root, %rax
    cmp $0, %rax
    je empty_tree
    movq $new_node, %rbx
traverse:
    cmpq %rax, %rbx
    je end #if root ==  new_node
    movq %rax, %rcx #backup
    jl left
    jmp right
left:
    movq 8(%rax), %rax
    cmp $0, %rax #reached a leaf
    jne traverse
    movq $new_node, 8(%rcx)
    jmp end
right:
    movq 16(%rax), %rax
    cmp $0, %rax #reached a leaf
    jne traverse
    movq $new_node, 16(%rcx)
    jmp end
empty_tree:
    movq $new_node, root
    jmp end
    
end:
