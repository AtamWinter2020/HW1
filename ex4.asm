.global _start

.section .text
_start:
    movq root, %rax # `rax` contains reference to the current node in the tree
    cmp $0, %rax
    je empty_tree
    movq $new_node, %rbx # `rbx` contains reference to `new_node`
traverse:
    movq (%rbx), %rdx
    cmpq (%rax), %rdx # Compare new_node.value and current_node.value
    movq %rax, %rcx # save reference to 
    je end
    jg right
left:
    movq 8(%rax), %rax # Update current to get left leaf address
    cmp $0, %rax # Check if left leaf is null
    jne traverse # If not null compare again
    movq $new_node, 8(%rcx) # Save new_node as left leaf
    jmp end
right:
    movq 16(%rax), %rax  # Update current to get right leaf address
    cmp $0, %rax # Check if right leaf is null
    jne traverse  # If not null compare new current
    movq $new_node, 16(%rcx)  # Save new_node as right leaf
    jmp end
empty_tree:
    # Update root to be the new leaf
    movq (new_node), %eax
    movq %eax, (root)
    movq 8(new_node), %eax
    movq %eax, 8(root)
    movq 16(new_node), %eax
    movq %eax, 16(root)
    jmp end
    
end:
