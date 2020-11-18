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
    movq %rbx, 8(%rcx) # Save new_node as left leaf
    jmp end
right:
    movq 16(%rax), %rax  # Update current to get right leaf address
    cmp $0, %rax # Check if right leaf is null
    jne traverse  # If not null compare new current
    movq %rbx, 16(%rcx)  # Save new_node as right leaf
    jmp end
empty_tree:
    # Update root (%rcx) to be the new leaf (%rbx). Temp values saved to %rax
    movq $new_node, root
    jmp end
    
end:
