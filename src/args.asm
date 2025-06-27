argc_check:
  mov rax, [rsp + 8]
  cmp rax, 2
  jne argc_check_failed
  ret

argc_check_failed:
  mov rax, 1
  mov rdi, 1
  mov rsi, msg_usage
  mov rdx, msg_usge_size
  syscall

  mov rax, 60
  mov rdi, 0x01
  syscall
