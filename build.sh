#!/bin/bash

set -e

for example_dir in examples/* ; do
  # use the top command instead if you want to use compressed instructions
  # the ch32v307 can do both (it has support for the C-extension)
  # clang --target=riscv32 -march=rv32imafc -c -o blink.o blink.s
  clang --target=riscv32 -march=rv32imaf -c -o "$example_dir/main.o" "$example_dir/main.s"

  llvm-objcopy -O binary "$example_dir/main.o" "$example_dir/main.bin"
done

