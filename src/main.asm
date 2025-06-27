section .bss
  memory resb 30000
  ; code resb 65535

section .data
  code db "-[--->+<]>-------.>--[----->+<]>-.[--->+<]>-.+[->+++<]>.+++++++++++++.[-->+++++<]>+++.++[->+++<]>+.++++++++.-..-------------.-[->+++<]>.++[->+++<]>+.++.[->++++++<]>.+[->+++<]>.--[--->+<]>-.--[->++++<]>+.----------.++++++.-[---->+<]>+++.---[->++++<]>+.-----.[------->++<]>.---[->++<]>.++[--->++<]>+.>++++++++++."
  code_size equ $ - code
  msg_usage db "Usage: ./interpreter <file>", 10
  msg_usge_size equ $ - msg_usage

section .text
  global _start

  _start:
    call argc_check
    pop rax ; pop argc
    pop rax ; pop program name
    pop rax ; pop arg 1 pointer

    call interpret
    jmp exit

  return:
    ret

  exit:
    mov rax, 60 ; exit
    mov rdi, 0x00 ; exit code 0
    syscall

  %include "src/args.asm"
  %include "src/interpreter.asm"