%define MAX_PROGRAM_SIZE 65535
%define MEMORY_SIZE 30000
%define STRUCT_STAT_SIZE 128

section .bss
  memory resb MEMORY_SIZE
  stat resb STRUCT_STAT_SIZE

  code resb MAX_PROGRAM_SIZE
  code_size resq 1

section .data
  msg_usage db "Usage: ./interpreter <file>", 10
  msg_usge_size equ $ - msg_usage
  msg_noaccess db "Unable to access the given file. Does it exist? Do you have read access?", 10
  msg_noaccess_size equ $ - msg_noaccess
  msg_cannotopen db "Unable to open the given file", 10
  msg_cannotopen_size equ $ - msg_cannotopen
  msg_program_too_big db "Program size exceeds limit of 65535 bytes.", 10
  msg_program_too_big_size equ $ - msg_program_too_big

section .text
  global _start

  _start:
    call argc_check
    pop rax ; pop argc
    pop rax ; pop program name

    pop rdi ; pop filename string pointer
    call can_access
    call open_file
    
    mov rdi, rax ; fd needs to be in rdi for fstat, read and close system calls
    call file_size
    mov [code_size], rax
    cmp dword [code_size], MAX_PROGRAM_SIZE
    jge program_too_big

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

  program_too_big:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_program_too_big
    mov rdx, msg_program_too_big_size
    syscall

    mov rax, 60
    mov rdi, 0x04
    syscall

  %include "src/args.asm"
  %include "src/fs.asm"
  %include "src/interpreter.asm"