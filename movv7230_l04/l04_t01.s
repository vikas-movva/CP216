/*
-------------------------------------------------------
l04_t01.s
-------------------------------------------------------
Author:  Vikas Movva
ID:      190957230
Email:   movv7230@mylaurier.ca
Date:    2025-02-14
-------------------------------------------------------
A program that calculates the sum of all the values in the list and displays that value in r1.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

ldr    r2, =Data    // Store address of start of list
ldr    r3, =_Data   // Store address of end of list
mov    r1, #0       // Initialize r1 to 0 to store the sum

Loop:
ldr    r0, [r2], #4 // Read address with post-increment (r0 = *r2, r2 += 4)
add    r1, r1, r0   // Add the value in r0 to r1 (sum)
cmp    r3, r2       // Compare current address with end of list
bne    Loop         // If not at end, continue

_stop:
b _stop

.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12    // The list of data
_Data: // End of list address

.end