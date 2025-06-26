section .bss
  memory resb 30000

section .data
  code db "-[--->+<]>-------.>--[----->+<]>-.[--->+<]>-.+[->+++<]>.+++++++++++++.[-->+++++<]>+++.++[->+++<]>+.++++++++.-..-------------.-[->+++<]>.++[->+++<]>+.++.[->++++++<]>.+[->+++<]>.--[--->+<]>-.--[->++++<]>+.----------.++++++.-[---->+<]>+++.---[->++++<]>+.-----.[------->++<]>.---[->++<]>.++[--->++<]>+.>++++++++++."
  code_size equ $ - code

section .text
  global _start

  _start:
    call interpret

  exit:
    mov rax, 60 ; exit
    mov rdi, 0 ; exit code 0
    syscall

  %include "src/interpreter.asm"