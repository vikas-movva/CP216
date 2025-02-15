/*
-------------------------------------------------------
count1.s
-------------------------------------------------------
Author:Vikas Movva
ID: 190957230
Email: movv7230@mylaurier.ca
Date: Feb. 7th, 2025
-------------------------------------------------------
A simple count down program (bgt)
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

.text // code section
// Store data in registers
mov r3, #5  // Initialize a countdown value

TOP:
sub r3, r3, #1 // Decrement the countdown value
cmp r3, #0  // Compare the countdown value to 0
bge TOP         // Branch to TOP if >= 0

_stop:
b _stop

.end
