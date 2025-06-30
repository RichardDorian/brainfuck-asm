%define F_OK 0
%define R_OK 4
%define O_RDONLY 0

can_access:
  mov rax, 21
  mov rsi, F_OK | R_OK
  syscall

  cmp rax, 0
  jne can_access_error
  ret

can_access_error:
  mov rax, 1
  mov rdi, 1
  mov rsi, msg_noaccess
  mov rdx, msg_noaccess_size
  syscall

  mov rax, 60
  mov rdi, 0x02
  syscall

; Opens the given file, puts the file descriptor in the rax register, puts -1 if fails
open_file:
  mov rax, 2
  mov rsi, O_RDONLY
  mov rdx, 0
  syscall

  cmp rax, -1
  je open_file_error
  ret

open_file_error:
  mov rax, 1
  mov rdi, 1
  mov rsi, msg_cannotopen
  mov rdx, msg_cannotopen_size
  syscall

  mov rax, 60
  mov rdi, 0x03
  syscall

file_size:
  mov rax, 5
  mov rsi, stat
  syscall
  
  mov rax, [stat+48]
  ret

read:
  mov rax, 0
  mov rsi, code
  mov rdx, [code_size]
  syscall
  ret

close:
  mov rax, 3,
  syscall
  ret