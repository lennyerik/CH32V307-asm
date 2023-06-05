# This example makes an LED connected to PB0 blink
# Sort of like the Arduino blink example, but in RISCV assembly

# These are from CH32FV2x_V3xRM.PDF section 10.3.1
.equ R32_GPIOB_CFGLR,   0x40010C00 # PB port configuration register low
.equ R32_GPIOB_OUTDR,   0x40010C0C # PB port output data register
.equ R32_RCC_APB2PCENR, 0x40021018 # APB2 peripheral clock enable register

# From https://github.com/openwch/ch32v307/blob/7ec2dd5a66cef60f88519a52d55230fc678093be/EVT/EXAM/SRC/Peripheral/inc/ch32v30x_rcc.h#L13
.equ RCC_APB2Periph_GPIOB, (1 << 3)

# This is the default config (0x44444444) except for the last bits, which set
# GPIOB into 2MHz (slow clock) push-pull output mode
.equ GPIOB_CONFIG, 0x44444441

.equ DELAY_CYCLES, 1000000


# Configure the clock source for the GPIOB peripheral
li t0, R32_RCC_APB2PCENR
lw t1, 0(t0)
ori t1, t1, RCC_APB2Periph_GPIOB
sw t1, 0(t0)

# Set pin 0 of GPIOB to (max) 2MHz push-pull output
li t0, R32_GPIOB_CFGLR
li t1, GPIOB_CONFIG
sw t1, 0(t0)

lp:
    # Write 1 to the GPIO output register (@ bit position 0), enabling pin 0
    li t0, R32_GPIOB_OUTDR
    li t1, 1
    sh t1, 0(t0)

    # Wait
    li a0, DELAY_CYCLES
    jal delay

    # Write 0 to the GPIO output register, disabling pin 0
    li t0, R32_GPIOB_OUTDR
    li t1, 0
    sh t1, 0(t0)

    # Wait
    li a0, DELAY_CYCLES
    jal delay
    
    j lp

delay:
    li t1, 0
    delay_loop:
        addi a0, a0, -1
        bne a0, t1, delay_loop
    ret

