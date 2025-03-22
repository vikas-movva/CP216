/*
-------------------------------------------------------
l05_t02.s
-------------------------------------------------------
Author: Vikas Movva
ID:     190957230
Email:  movv7230@mylaurier.ca
Date:    2025-02-26
-------------------------------------------------------
Calculates stats on an integer list.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

mov    r1, #0       // Initialize counters
mov    r2, #0
mov    r3, #0
ldr    r4, =Data    // Store address of start of list
ldr    r5, =_Data   // Store address of end of list
bl     list_stats   // Call subroutine - total returned in r0

_stop:
b      _stop

//-------------------------------------------------------
list_stats:
/*
-------------------------------------------------------
Counts number of positive, negative, and 0 values in a list.
Equivalent of: void stats(*start, *end, *zero, *positive, *negatives)
-------------------------------------------------------
Parameters:
  r1 - number of zero values
  r2 - number of positive values
  r3 - number of negative values
  r4 - start address of list
  r5 - end address of list
Uses:
  r0 - temporary value
-------------------------------------------------------
*/

stmfd sp!, {r4-r5}

Loop:
ldr    r0, [r4], #4 // Read address with post-increment (r0 = *r4, r4 += 4)

cmp r0, #0
addeq r1, r1, #1
addgt r2, r2, #1
addlt r3, r3, #1

cmp    r4, r5       // Compare current address with end of list
blt    Loop         // If not at end, continue

ldmfd sp!, {r4-r5}
bx lr

.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12    // The list of data
_Data: // End of list address

.end