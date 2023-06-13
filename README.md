# CH32V307 assembly fun
This repo is about progamming the CH32V307 microcontroller using raw RISCV32 assembly and an open source toolchain.
Specifically, this was written for the CH32V307V-R1-1v0 devboard (about $15 on LCSC).

Since the devboard comes with a debug interface, it is great for learning RISCV programming.

## Details about the CH32V307
### Memory map
Since the docs on the memory map are terrible, here is a quick overview:

* program flash starts at 0x08000000
* sram (program ram) starts at 0x20000000
* peripheral control memory starts at 0x40000000

Source: https://github.com/openwch/ch32v307/blob/7ec2dd5a66cef60f88519a52d55230fc678093be/EVT/EXAM/SRC/Peripheral/inc/ch32v30x.h#L1120

### Documents
* http://www.wch-ic.com/downloads/CH32FV2x_V3xRM_PDF.html (more useful)
    * chapter 10.3.1 lists GPIO registers
* http://www.wch-ic.com/downloads/CH32V307DS0_PDF.html (less useful)
* http://www.wch-ic.com/downloads/QingKeV4_Processor_Manual_PDF.html
* https://github.com/openwch/ch32v307/tree/main -- Github containing links to docs and schematics


## Setup
Make sure you have llvm and clang installed.
Then install [wlink](https://github.com/ch32-rs/wlink).
**DISCLAIMER: wlink is not my project. This is just my fork, which fixes a bug when interacting with the CH32V307V-R1-1v0 board. See [#16](https://github.com/ch32-rs/wlink/issues/16) for details. Big thanks to the folks at ch32-rs for developing such an amazing tool!**

    cargo install --git https://github.com/lennyerik/wlink

## Building and running the examples
### Assembling

    ./build.sh

Look at `build.sh` to learn how to assemble your own code.
I promise it's just two commands.

To dump the generated code for a compiled example, run:

    cd examples/<EXAMPLE>
    llvm-objdump -d main.o

### Flashing
Plug in your devboard, then run

    cd examples/<EXAMPLE>
    wlink flash main.bin

## Using wlink
To dump all registers, run

    wlink regs

To dump memory, run

    wlink dump <ADDRESS> <SIZE>

and you get a nice hexdump-like view of the memory range.

To write registers and memory, you can use

    wlink write-reg <REG> <VALUE>

and

    wlink write-mem <ADDRESS> <VALUE>

