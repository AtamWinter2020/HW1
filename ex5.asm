.global _start

.section .text
_start:
  movq (head), %rbx  # Get address of first node
  cmpq $0, %rbx
  movq $head, %r12 # prev_node = head
  je end # Empty list is a sorted list
  jmp loop
loop_update_prev: # Only advance prev if in order
  movq %rax, %r12 # prev_node = curr_node
loop: # Loop through all the items in the list
  # Update curr_node and next_node
  movq %rbx, %rax # curr_node = next_node
  movq 8(%rax), %rbx # next_node = curr_node->next
  movq (%rax), %r8 # `%r8` = curr_node->value
  # Check in order
  cmp %r8, (%r12)
  jg loop_update_prev # skip if (curr > prev)
  # Bubble node
  movq %rbx, 8(%r12) # detach current: prev_node->next = next_node
  call bubble # Bubble current to the right place from the beginning

  # TODO: Check if needs to check whether new node added just before next (meaning not moved). It's probably not needed because we check it's bigger than prev
  # cmp %rax, %rbx
  # jne loop_not_adjecent
  # movq %rdx, %r12
# loop_not_adjecent:
  cmp $0, %rbx
  jne loop # STOP COND (next_node == NULL)
  # We want to keep prev_node as is
  jmp end

bubble:
  movq (head), %rax # Get head
  # `%rdx` contains ref to current node
  movq (%rdx), %r8 # `%r8` = new_node->value
  movq $head, %rcx # `%rcx` is the address of prev->next
  jmp bubble_start
bubble_loop:
  lea 8(%rax), %rcx # prev_next = curr->next
  movq %rcx, %rax # curr = curr->next
  cmp $0, %rax # If next is null
  je bubble_end # Save as last
bubble_start:
  cmp %r8, 0(%rax)
  jg bubble_loop # new_node.value < curr_node.value
bubble_end:
  movq %rdx, (%rcx) # *prev_next = new_node
  movq %rax, 8(%rdx) # new_node->next = curr_node
  ret


end:
