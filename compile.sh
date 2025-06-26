#!/bin/bash

# Clean previous builds
mkdir -p ./build
rm -f ./build/*

DEBUG_FLAGS=""
if [[ "$1" == "--dev" ]]; then
    DEBUG_FLAGS="-g -F dwarf"
fi

nasm -f elf64 $DEBUG_FLAGS src/main.asm -o build/interpreter.o
ld -x build/interpreter.o -o build/interpreter