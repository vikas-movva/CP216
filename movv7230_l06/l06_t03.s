/*
-------------------------------------------------------
l06_t03.s
-------------------------------------------------------
Author:
ID:
Email:
Date:    2024-02-22
-------------------------------------------------------
Working with stack frames.
Finds the common prefix of two null-terminated strings.
-------------------------------------------------------
*/
// Constants
.equ SIZE, 80

.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:
// Load addresses and value
ldr r0, =First      // Address of first string
ldr r1, =Second     // Address of second string
ldr r2, =Common     // Address of common buffer
mov r3, #SIZE       // Maximum size of common

// Push parameters onto the stack in reverse order
stmfd sp!, {r3}     // Push size
stmfd sp!, {r2}     // Push common
stmfd sp!, {r1}     // Push second
stmfd sp!, {r0}     // Push first

bl     FindCommon   // Call the subroutine

// Clean up stack (remove 4 parameters, each 4 bytes)
add sp, sp, #16

_stop:
b      _stop

//-------------------------------------------------------
FindCommon:
/*
-------------------------------------------------------
Equivalent of: FindCommon(*first, *second, *common, size)
Finds the common parts of two null-terminated strings from the beginning of the
strings. Example:
first: "pandemic"
second: "pandemonium"
common: "pandem", length 6
-------------------------------------------------------
Parameters:
  first - pointer to start of first string
  second - pointer to start of second string
  common - pointer to storage of common string
  size - maximum size of common
Uses:
  r0 - address of first
  r1 - address of second
  r2 - address of common
  r3 - value of max length of common
  r4 - character in first
  r5 - character in second
-------------------------------------------------------
*/

// Prologue: save registers and get parameters from stack
stmfd sp!, {r4, r5, lr}  // Save r4, r5, and link register
ldr r0, [sp, #12]        // Load first from stack
ldr r1, [sp, #16]        // Load second from stack
ldr r2, [sp, #20]        // Load common from stack
ldr r3, [sp, #24]        // Load size from stack

FCLoop:
cmp    r3, #1          // Is there room left in common?
beq    _FindCommon     // No, leave subroutine
ldrb   r4, [r0], #1    // Get next character in first
ldrb   r5, [r1], #1    // Get next character in second
cmp    r4, r5
bne    _FindCommon     // If characters don't match, leave subroutine
cmp    r5, #0          // Reached end of first/second?
beq    _FindCommon
strb   r4, [r2], #1    // Copy character to common
sub    r3, r3, #1      // Decrement space left in common
b      FCLoop

_FindCommon:
mov    r4, #0
strb   r4, [r2]        // Terminate common with null character

// Epilogue: clean up stack and return from subroutine
ldmfd sp!, {r4, r5, pc}  // Restore r4, r5, and return

//-------------------------------------------------------
.data
First:
.asciz "pandemic"
Second:
.asciz "pandemonium"
Common:
.space SIZE

.end