/*
-------------------------------------------------------
l08_t02.s
-------------------------------------------------------
Author:
ID:
Email:
Date:    2024-02-21
-------------------------------------------------------
Uses a subroutine to read strings from the UART into memory.
-------------------------------------------------------
*/
// Constants
.equ SIZE, 20 // Size of string buffer storage (bytes)

.org 0x1000   // Start at memory location 1000
.text         // Code section
.global _start
_start:
// Set buffer size and read strings
mov r5, #20
ldr r4, =First
bl ReadString
mov r5, #20
ldr r4, =Second
bl ReadString
mov r5, #20
ldr r4, =Third
bl ReadString
mov r5, #20
ldr r4, =Last
bl ReadString

_stop:
b _stop

// Subroutine constants
.equ UART_BASE, 0xff201000  // UART base address
.equ ENTER, 0x0A            // The enter key code
.equ VALID, 0x8000          // Valid data in UART mask

ReadString:
/*
-------------------------------------------------------
Reads an ENTER terminated string from the UART.
-------------------------------------------------------
Parameters:
  r4 - address of string buffer
  r5 - size of string buffer
Uses:
  r0 - holds character to print
  r1 - address of UART
  r2 - index into the buffer
  r3 - maximum index for storing characters
-------------------------------------------------------
*/

//=======================================================
stmfd sp!, {r1-r5, lr}
ldr r1, =UART_BASE
mov r2, #0
sub r3, r5, #1

Loop:
ldr     r1, =UART_BASE  
ldr     r0, [r1]        
tst     r0, #VALID      
moveq   r0, #0x48        
andne   r0, r0, #0x00FF 

cmp r0, #ENTER
beq _ReadString
cmp r2, r3
bge _ReadString
strb r0, [r4, r2]
add r2, r2, #1
b Loop

_ReadString:
mov r0, #0
strb r0, [r4, r2]
ldmfd sp!, {r1-r5, lr}
bx lr

.data
.align
// The list of strings
First:
.space  SIZE
Second:
.space SIZE
Third:
.space SIZE
Last:
.space SIZE
_Last:    // End of list address

.end