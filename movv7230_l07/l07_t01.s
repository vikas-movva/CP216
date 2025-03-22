/*
-------------------------------------------------------
l07_t01.s
Subroutines for working with characters.
-------------------------------------------------------
Author:
ID:
Email:
Date:    2024-02-22
-------------------------------------------------------
*/
.org    0x1000    // Start at memory location 1000
.text  // Code section
.global _start
_start:

// Type a character into the UART to test
bl  ReadChar
mov r2, r0
ldr r4, =characterStr
bl  PrintString
bl  PrintChar
bl  PrintEnter

ldr r4, =isLetterStr
bl  PrintString
bl  isLetter
bl  PrintTrueFalse
bl  PrintEnter

ldr r4, =isLowerStr
bl  PrintString
bl  isLowerCase
bl  PrintTrueFalse
bl  PrintEnter

ldr r4, =isUpperStr
bl  PrintString
bl  isUpperCase
bl  PrintTrueFalse
bl  PrintEnter

_stop:
B    _stop

//-------------------------------------------------------
// Constants
.equ UART_BASE, 0xff201000     // UART base address
.equ ENTER, 0x0a     // enter character
.equ VALID, 0x8000   // Valid data in UART mask

//-------------------------------------------------------
ReadChar:
/*
-------------------------------------------------------
Reads single character from UART.
-------------------------------------------------------
Uses:
  r1 - address of UART
Returns:
  r0 - value of character, null if UART Read FIFO empty
-------------------------------------------------------
*/
stmfd   sp!, {r1, lr}
ldr     r1, =UART_BASE  // Load UART base address
ldr     r0, [r1]        // read the UART data register
tst     r0, #VALID      // check if there is new data
moveq   r0, #0          // if no data, return 0
andne   r0, r0, #0x00FF // else return only the character
_ReadChar:
ldmfd   sp!, {r1, lr}
bx      lr

//-------------------------------------------------------
PrintChar:
/*
-------------------------------------------------------
Prints single character to UART.
-------------------------------------------------------
Parameters:
  r2 - address of character to print
Uses:
  r1 - address of UART
-------------------------------------------------------
*/
stmfd   sp!, {r1, lr}
ldr     r1, =UART_BASE  // Load UART base address
strb    r2, [r1]        // copy the character to the UART DATA field
ldmfd   sp!, {r1, lr}
bx      lr

//-------------------------------------------------------
PrintString:
/*
-------------------------------------------------------
Prints a null terminated string to the UART.
-------------------------------------------------------
Parameters:
  r4 - address of string
Uses:
  r1 - address of UART
  r2 - current character to print
-------------------------------------------------------
*/
stmfd   sp!, {r1-r2, r4, lr}
ldr     r1, =UART_BASE
psLOOP:
ldrb    r2, [r4], #1     // load a single byte from the string
cmp     r2, #0           // compare to null character
beq     _PrintString     // stop when the null character is found
strb    r2, [r1]         // else copy the character to the UART DATA field
b       psLOOP
_PrintString:
ldmfd   sp!, {r1-r2, r4, lr}
bx      lr

//-------------------------------------------------------
PrintEnter:
/*
-------------------------------------------------------
Prints the ENTER character to the UART.
-------------------------------------------------------
Uses:
  r2 - holds ENTER character
-------------------------------------------------------
*/
stmfd   sp!, {r2, lr}
mov     r2, #ENTER       // Load ENTER character
bl      PrintChar
ldmfd   sp!, {r2, lr}
bx      lr

//-------------------------------------------------------
PrintTrueFalse:
/*
-------------------------------------------------------
Prints "T" or "F" as appropriate
-------------------------------------------------------
Parameter
  r0 - input parameter of 0 (false) or 1 (true)
Uses:
  r2 - 'T' or 'F' character to print
-------------------------------------------------------
*/
stmfd   sp!, {r2, lr}
cmp     r0, #0           // Is r0 False?
moveq   r2, #'F'         // load "False" message
movne   r2, #'T'         // load "True" message
bl      PrintChar
ldmfd   sp!, {r2, lr}
bx      lr

//-------------------------------------------------------
isLowerCase:
/*
-------------------------------------------------------
Determines if a character is a lower case letter.
-------------------------------------------------------
Parameters
  r2 - character to test
Returns:
  r0 - returns True (1) if lower case, False (0) otherwise
-------------------------------------------------------
*/
mov    r0, #0           // default False
cmp    r2, #'a'
blt    _isLowerCase     // less than 'a', return False
cmp    r2, #'z'
movle  r0, #1           // less than or equal to 'z', return True
_isLowerCase:
bx lr

//-------------------------------------------------------
isUpperCase:
/*
-------------------------------------------------------
Determines if a character is an upper case letter.
-------------------------------------------------------
Parameters
  r2 - character to test
Returns:
  r0 - returns True (1) if upper case, False (0) otherwise
-------------------------------------------------------
*/
mov    r0, #0           // default False
cmp    r2, #'A'
blt    _isUpperCase     // less than 'A', return False
cmp    r2, #'Z'
movle  r0, #1           // less than or equal to 'Z', return True
_isUpperCase:
bx lr

//-------------------------------------------------------
isLetter:
/*
-------------------------------------------------------
Determines if a character is a letter.
-------------------------------------------------------
Parameters
  r2 - character to test
Returns:
  r0 - returns True (1) if letter, False (0) otherwise
-------------------------------------------------------
*/

// there is one error when running this subroutine:
// 1. Return Address Mismatch: "Function expected to return to 00001024, 
// but is trying to return to 0000111c" and 
// "Function expected to return to 00001020, but is trying to return to 0000111c".
// this can be solved by preserving the link register to the stack

    stmfd   sp!, {lr}   // Save r4 and lr
    bl      isLowerCase     // Test for lowercase
    cmp     r0, #1          // Is it lowercase?
    beq     _isLetter_exit  // If yes, exit
    bl      isUpperCase     // Test for uppercase
_isLetter_exit:
    ldmfd   sp!, {lr}   // Restore r4 and lr
    bx      lr              // Return
	
	
//bl      isLowerCase     // test for lowercase
//cmp     r0, #0
//bleq    isUpperCase     // not lowercase? Test for uppercase.
//bx      lr

//-------------------------------------------------------
.data
characterStr:
.asciz "Char: "
isLetterStr:
.asciz "Letter: "
isLowerStr:
.asciz "Lower: "
isUpperStr:
.asciz "Upper: "
_Data:

.end