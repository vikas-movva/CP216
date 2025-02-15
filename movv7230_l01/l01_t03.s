/*
-------------------------------------------------------
intro.s
-------------------------------------------------------
Author:Vikas Movva
ID:190957230
Email:movv7230@mylaurier.ca
Date:01/21/2025
-------------------------------------------------------
Assign to and add contents of registers.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

mov r0, #9       // Store decimal 9 in register r0
mov r1, #14     // Store hex E (decimal 14) in register r1
add r2, r1, r0  // Add the contents of r0 and r1 and put result in r2

mov r3, #8      // Store the decimal 8 in register r3 
add r3, r3, r3  // Add the contents of r3 to r3 and put the results in r3

add r4, r3, #5  // Add the the decimals 4 and 5 and put the results in r4
// End program
_stop:
b _stop