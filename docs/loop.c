// Loop look ahead algorithm
// I have never compiled this file so I have no idea if it works
// Its sole purpuse is to write readable code to "create" the algorithm

int main() {
  uint8_t *memory = malloc(30000);

  uint8_t[] program = "-[------->+<]>-.--[-->+++<]>.";
  uint64_t program_size = get_size_somehow(program);

  uint64_t instruction_ptr = 0x0;
  uint64_t memory_ptr = 0x0;

  // This function moves to the next instruction
  void next() {
    instruction_ptr++;
  }

  // Other brainfuck instructions are omitted because they do not require
  // much thinking before an assembly implementation

  // interpret_loop_start
  if (&(program + instruction_ptr) == '[') {
    push(instruction_ptr);

    if (&(memory + memory_ptr) == 0) {
      // move to the instruction next to the corresponding loop end

      uint64_t depth = 0;
      uint64_t tmp_instruction_ptr = instruction_ptr;

      while (true) {
        tmp_instruction_ptr++;
        if (&(program + tmp_instruction_ptr) == '[') {
          depth++;
        }

        if (&(program + tmp_instruction_ptr) == ']') {
          if (depth == 0) break;
          else: depth--;
        }
      }

      // after this loop next loop end is @ program + tmp_instruction_ptr
      instruction_ptr = tmp_instruction_ptr;
      next();
    } else {
      next();
    }
  }

  // interpret_loop_end
  if (&(program + instruction_ptr) == ']') {
    if (&(memory + memory_ptr) == 0) {
      // Loop is finished so we exit the loop and clean the stack
      pop();
      next();
    } else {
      uint64_t loop_start_ptr = get_value_top_stack();
      instruction_ptr = loop_start_ptr + 1;
    }
  }
}