section .bss
  memory resb 30000
  stat resb 128 ; struct stat

  code resb 65535
  code_size resb 8

section .data
  msg_usage db "Usage: ./interpreter <file>", 10
  msg_usge_size equ $ - msg_usage
  msg_noaccess db "Unable to access the given file. Does it exist? Do you have read access?", 10
  msg_noaccess_size equ $ - msg_noaccess
  msg_cannotopen db "Unable to open the given file", 10
  msg_cannotopen_size equ $ - msg_cannotopen

section .text
  global _start

  _start:
    call argc_check
    pop rax ; pop argc
    pop rax ; pop program name

    pop rdi ; pop filename pointer into rdi
    call can_access
    call open_file ; puts the fd in rax
    
    mov rdi, rax
    call file_size
    mov [code_size], rax
    ; TODO: allocate memory dynamically
    call read
    call close
    call interpret
    jmp exit

  return:
    ret

  exit:
    mov rax, 60 ; exit
    mov rdi, 0x00 ; exit code 0
    syscall

  %include "src/args.asm"
  %include "src/fs.asm"
  %include "src/interpreter.asm"