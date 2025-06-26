%macro set_instruction 2
  cmp byte [code + r9], %1
  je %2
%endmacro

interpret:
  mov r8, 0           ; data ptr
  mov r9, 0           ; instruction ptr
  mov r14, 0          ; loop stack ptr
  mov r15, code_size  ; program size

interpret_loop:
  cmp r9, r15         ; exit if program reached the end
  jge exit

  set_instruction '+', interpret_inc_val
  set_instruction '-', interpret_dec_val
  set_instruction '>', interpret_inc_ptr
  set_instruction '<', interpret_dec_ptr
  set_instruction '.', interpret_write
  set_instruction ',', interpret_read
  set_instruction '[', interpret_loop_start
  set_instruction ']', interpret_loop_end

next:
  inc r9
  jmp interpret_loop

interpret_inc_val:
  inc byte [memory+r8]
  jmp next

interpret_dec_val:
  dec byte [memory+r8]
  jmp next

interpret_inc_ptr:
  inc r8
  ; todo: add bounds checking so it is not possible to increment outside the 30k bytes buffer
  jmp next

interpret_dec_ptr:
  dec r8
  ; todo: add bounds checking so it is not possible to dec outside the 30k bytes buffer
  jmp next

interpret_write:
  mov rax, 1              ; write
  mov rdi, 1              ; stdout
  lea rsi, [memory + r8]
  mov rdx, 1              ; only write 1 byte
  syscall
  jmp next

interpret_read:
  mov rax, 0              ; read
  mov rdi, 1              ; stdout
  lea rsi, [memory + r8]
  mov rdx, 1              ; only 1 byte
  syscall
  jmp next

interpret_loop_start:
  push r9

  cmp byte [memory + r8], 0
  je interpret_loop_search
  jmp next

interpret_loop_search:
  mov rax, 0    ; depth
  mov rbx, r9   ; tmp_instruction_ptr
interpret_loop_search_loop:
  inc rbx
  cmp byte [code + rbx], '['
  je interpret_loop_search_loop_start
  cmp byte [code + rbx], ']'
  je interpret_loop_search_loop_end
  jmp interpret_loop_search_loop

interpret_loop_search_loop_start:
  inc rax
  jmp interpret_loop_search_loop

interpret_loop_search_loop_end:
  cmp rax, 0
  je interpret_loop_search_end
  dec rax
  jmp interpret_loop_search_loop

interpret_loop_search_end:
  mov r9, rbx          ; corresponding loop end
  jmp next

interpret_loop_end:
  cmp byte [memory + r8], 0
  je interpret_loop_end_next
  mov r9, [rsp]
  jmp next
interpret_loop_end_next:
  pop rax
  jmp next