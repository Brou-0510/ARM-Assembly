/*
-------------------------------------------------------
l06_t01.s
Demonstrates the use of a subroutine to print to the UART.
Prints an end of line character at the end of the string it sends to the UART.
-------------------------------------------------------
Author:  Paige Broussard
ID:      190832520
Email:   brou2520@mylaurier.ca
Date:    2021-03-04
-------------------------------------------------------
*/
.org    0x1000    // Start at memory location 1000
.text  // Code section
.global _start
_start:

LDR R4, =First
BL  PrintString
LDR R4, =Second
BL  PrintString
LDR R4, =Third
BL  PrintString
LDR R4, =Last
BL  PrintString

_stop:
B    _stop

// Subroutine constants
.equ UART_BASE, 0xff201000     // UART base address

PrintString:
/*
-------------------------------------------------------
Prints a null terminated string.
-------------------------------------------------------
Parameters:
  R4 - address of string
Uses:
  R0 - holds character to print
  R1 - address of UART
-------------------------------------------------------
*/
STMFD  SP!, {R0-R1, R4, LR}
LDR R1, =UART_BASE

psLOOP:
LDRB R0, [R4], #1   // load a single byte from the string
CMP  R0, #0
BEQ  _PrintString   // stop when the null character is found
STR  R0, [R1]       // copy the character to the UART DATA field
B    psLOOP
_PrintString:
MOV R2, #0x0a // my code
STR R2, [R1]  // my code
LDMFD  SP!, {R0-R1, R4, PC}

.data
.align
// The list of strings
First:
.asciz  "First string"
Second:
.asciz  "Second string"
Third:
.asciz  "Third string"
Last:
.asciz  "Last string"
_Last:    // End of list address

.end