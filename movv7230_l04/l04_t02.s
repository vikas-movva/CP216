/*
-------------------------------------------------------
l04_t02.s
-------------------------------------------------------
Author:  Vikas Movva
ID:      190957230
Email:   movv7230@mylaurier.ca
Date:    2025-02-14
-------------------------------------------------------
A program that counts the number of values in the list (r4) and the number of bytes in the list (r5).
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

ldr    r2, =Data    // Load start address of the list
ldr    r3, =_Data   // Load end address of the list

sub    r5, r3, r2   // Calculate number of bytes (end - start) into r5
mov    r4, r5, lsr #2 // Calculate number of elements (bytes / 4) into r4 by right-shifting 2 bits

_stop:
b _stop              // Infinite loop to stop execution

.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12    // The list of data
_Data: // End of list address

.end