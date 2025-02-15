/*
-------------------------------------------------------
l04_t03.s
-------------------------------------------------------
Author:  Vikas Movva
ID:      190957230
Email:   movv7230@mylaurier.ca
Date:    2025-02-14
-------------------------------------------------------
A program that calculates the minimum (r6) and maximum (r7) values in the list using conditional execution.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

ldr    r2, =Data    // Load start address of the list
ldr    r3, =_Data   // Load end address of the list

ldr    r0, [r2], #4 // Load first element and increment address
mov    r6, r0       // Initialize minimum to first element
mov    r7, r0       // Initialize maximum to first element

Loop:
cmp    r2, r3       // Check if current address has reached the end
bge    _stop        // If yes, exit loop
ldr    r0, [r2], #4 // Load next element and increment address
cmp    r0, r6       // Compare current element with minimum
movlt  r6, r0       // Update minimum if current element is smaller
cmp    r0, r7       // Compare current element with maximum
movgt  r7, r0       // Update maximum if current element is larger
b      Loop         // Repeat the loop

_stop:
b _stop              // Infinite loop to stop execution

.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12    // The list of data
_Data: // End of list address

.end