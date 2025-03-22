/*
-------------------------------------------------------
l05_t01.s
-------------------------------------------------------
Author:  Vikas Movva
ID:      190957230
Email:   movv7230@mylaurier.ca
Date:    2024-02-21
-------------------------------------------------------
Does a running total of an integer list.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

ldr    r1, =Data    // Store address of start of list
ldr    r2, =_Data   // Store address of end of list
bl     list_total   // Call subroutine - total returned in r0

_stop:
b _stop


//-------------------------------------------------------
list_total:
/*
-------------------------------------------------------
Totals values in a list.
Equivalent of: int total(*start, *end)
-------------------------------------------------------
Parameters:
  r1 - start address of list
  r2 - end address of list
Uses:
  r3 - temporary value
Returns:
  r0 - total of values in list
-------------------------------------------------------
*/
stmfd sp!, {r1-r3}

mov r0, #0          // Initialize r0

Loop:
ldr    r3, [r1], #4 // Read address with post-increment (r0 = *r1, r1 += 4)
add    r0, r0, r3   // Add the value in r3 to r0 (sum)
cmp    r1, r2       // Compare current address with end of list
bne    Loop         // If not at end, continue

ldmfd sp!, {r1-r3}
bx lr

// your code here


.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12    // The list of data
_Data: // End of list address

.end