/*
-------------------------------------------------------
l06_t02.s
Reads strings from the UART into the appropriate string storage.
-------------------------------------------------------
Author:  Paige Broussard
ID:      190832520
Email:   brou2520@mylaurier.ca
Date:    2021-03-04
-------------------------------------------------------
*/
// Constants
.equ SIZE, 20    	// Size of string buffer storage (bytes)
.text  // Code section
.org	0x1000	// Start at memory location 1000
.global _start
_start:

MOV    R5, #SIZE
LDR    R4, =First
BL	   ReadString
LDR    R4, =Second
BL	   ReadString
LDR    R4, =Third
BL     ReadString
LDR    R4, =Last
BL     ReadString
    
_stop:
B	_stop

// Subroutine constants
.equ UART_BASE, 0xff201000     // UART base address
.equ VALID, 0x8000	// Valid data in UART mask
.equ DATA, 0x00FF	// Actual data in UART mask
.equ ENTER, 0x0A	// End of line character

ReadString:
/*
-------------------------------------------------------
Reads an ENTER terminated string from the UART.
-------------------------------------------------------
Parameters:
  R4 - address of string buffer
  R5 - size of string buffer
Uses:
  R0 - holds character to print
  R1 - address of UART
-------------------------------------------------------
*/

// your code here
STMFD  SP!, {R0-R1, R4-R5, LR}
LDR  R1, =UART_BASE

LOOP:
LDRB  R0, [R1]  // read the UART data register
CMP R0, #ENTER // compare the UART value to the enter value
BEQ  _ReadString         
STRB R0, [R4]      // store the character in memory
ADD  R4, R4, #1    // move to next byte in storage buffer
CMP  R4, R5        // end program if buffer full
BEQ  _ReadString
B    LOOP

_ReadString:
LDMFD  SP!, {R0-R1, R4-R5, PC}
	
.data
.align
// The list of strings
First:
.space  SIZE
Second:
.space	SIZE
Third:
.space	SIZE
Last:
.space	SIZE
_Last:    // End of list address

.end
	