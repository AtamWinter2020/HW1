.global _start

.section .text
_start:
  cmp $0, (head)
  je end # Empty list is a sorted list
  movq (head), %rbx  # next_node = head
  movq $head, %r12 # prev_next = head
  movq %rbx, %rax # curr_node = next_node
  jmp loop
loop_update_prev: # Only advance prev if in order
  cmp $0, %rbx
  je end
  leaq 8(%rax), %r12 # prev_next = curr_node->next
loop: # Loop through all the items in the list
  # Update curr_node and next_node
  movq %rbx, %rax # curr_node = next_node
  movq 8(%rax), %rbx # next_node = curr_node->next
  movl (%rax), %r8d # `%r8` = curr_node->value

  # If head
  cmp $head, %r12
  je loop_update_prev

  # Check in order
  movl -8(%r12d), %r9d
  cmpl %r8d, %r9d
  jb loop_update_prev # skip if (curr > prev)
call_bubble:
  # Bubble node
  movq %rbx, (%r12) # detach current: prev_node->next = next_node
  movq %rax, %rdx
  call bubble # Bubble current to the right place from the beginning
  # Stop condition
  cmp $0, %rbx
  jne loop # If (next_node == NULL)
  # We want to keep prev_node as is
  jmp end

bubble:
  movq (head), %rax # Get head
  # `%rdx` contains ref to current node
  movl 0(%rdx), %r8d # `%r8` = new_node->value
  movq $head, %rcx # `%rcx` is the address of prev->next
  jmp bubble_start
bubble_loop:
  leaq 8(%rax), %rcx # prev_next = curr->next
  movq 8(%rax), %rax # curr = curr->next
  cmp $0, %rax # If next is null
  je bubble_end # Save as last
bubble_start:
  movl 0(%rax), %r9d
  cmpl %r9d, %r8d
  ja bubble_loop # new_node.value < curr_node.value
bubble_end:
  movq %rdx, (%rcx) # *prev_next = new_node
  movq %rax, 8(%rdx) # new_node->next = curr_node
  ret

end:
