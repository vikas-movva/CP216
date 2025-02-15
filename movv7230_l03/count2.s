/*
-------------------------------------------------------
count2.s
-------------------------------------------------------
Author:Vikas Movva
ID:190957230
Email:movv7230@mylaurier.ca
Date:Feb. 7th, 2025
-------------------------------------------------------
A simple count down program (bge)
-------------------------------------------------------
*/


.org 0x1000 // Start at memory location 1000
.text       // Code section
.global _start
_start:
// Load data from memory into register
ldr r3, =COUNTER  // Get address of COUNTER
ldr r3, [r3]      // Load value at COUNTER into r3

TOP:
sub r3, r3, #1    // Decrement the countdown value
cmp r3, #0        // Compare the countdown value to 0
bge TOP           // Branch to top under certain conditions

_stop:
b _stop
.data       // Data section
COUNTER:    // Label for our counter value
.word 5     // Store initial value 5
.end