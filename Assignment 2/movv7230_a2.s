.org 0x1000
.text
.global _start
_start:
    ldr R0, =Data           // R0 = address of Data
    ldr R1, =0x1500         // R1 = destination address (00001500)
    mov R2, #16             // R2 = loop counter (16 elements)
    ldr R5, =ASCII_table    // R5 = address of ASCII_table

loop:
    ldr R3, [R0], #4        // Load word from Data into R3, increment R0 by 4
    ldrb R4, [R5, R3]       // Load ASCII byte from ASCII_table[R3] into R4
    strb R4, [R1], #1       // Store ASCII byte to address in R1, increment R1 by 1
    subs R2, R2, #1         // Decrement counter, set flags
    bne loop                // If counter != 0, repeat loop

_stop:
    b _stop                   // Infinite loop to halt program

.data
.align
Data:
    .word 0xA, 0xB, 0xC, 0x1, 0x2, 0x4, 0x9, 0x3
    .word 0xD, 0xF, 0xE, 0x7, 0x5, 0x6, 0x8, 0x0

ASCII_table:
    .byte 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37
    .byte 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46
	
.end