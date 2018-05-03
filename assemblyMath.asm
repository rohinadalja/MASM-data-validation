TITLE MASM Arithmetic       (assemblyMath.asm)

; Author: Rohin Adalja
; Description: This program will display my name and program title to the
;   output screen, and will prompt the user to enter two numbers. The program
;   will then produce the sum, difference, product, integer quotient and
;   remainder of the two numbers. Finally, the program will display a
;   terminating message.
;
;   ** Program repeats until the user chooses to quit.
;   ** Program verifies second number less than first.
;   ** Program calculates result as floating-point (rounded to .001).

INCLUDE Irvine32.inc

.data
	intro_1	    BYTE	"Assembly Arithmetic - Rohin Adalja", 0
	intro_2	    BYTE	"Enter two numbers, and it will display the sum, difference,", 0 
	intro_3     BYTE	"product integer quotient and remainder.", 0
	intro_EC1   BYTE	"  ** Program repeats until the user chooses to quit.", 0
	intro_EC2   BYTE	"  ** Program verifies second number less than first.", 0
	intro_EC3   BYTE	"  ** Program calculates result as floating-point (rounded to .001).", 0
	prompt_1    BYTE	"Enter your first number: ", 0
	num_1       DWORD	?
	prompt_2    BYTE	"Enter your second number: ", 0
	num_2       DWORD	?
	prompt_3    BYTE	"EC #1: Input 1 to continue, Input 0 to QUIT: ", 0
	continue    DWORD	?

	show_res    BYTE	"These are your results:", 0
	show_ans    BYTE	" = ", 0
	show_sum    BYTE	" + ", 0
	show_dif    BYTE	" - ", 0
	show_mul    BYTE	" x ", 0
	show_div    BYTE	" / ", 0
	show_rem    BYTE	" remainder ", 0
	show_EC3    BYTE	"Floating point result (EC #3 Rounded to .001) = ", 0

	result_sum  DWORD	?
	result_dif  DWORD	?
	result_mul  DWORD	?
	result_div  DWORD	?
	result_rem  DWORD	?

; For floating division conversion and rounding (EC #3)
	EC3_num1    REAL8	?
	EC3_num2    REAL8	?
	EC3_conv    REAL8	0.00
	round1      REAL8	1000.0
	round2      REAL8	1000.0
	result_EC3  REAL8	?

	no_loop 	DWORD	0					; comparing user input to this value for loop repeat (EC #1)

	error_EC2   BYTE	"The second number must be less than the first!", 0
	goodbye     BYTE	"Hope I did this right... Goodbye from Rohin!", 0

.code
main PROC

; Display program title, programmer name, and instructions
	mov	  edx, OFFSET intro_1
	call  WriteString
	call  CrLf
	mov   edx, OFFSET intro_2
	call  WriteString
	call  CrLf
	mov   edx, OFFSET intro_3
	call  WriteString
	call  CrLf
	mov   edx, OFFSET intro_EC1
	call  WriteString
	call  CrLf
	mov   edx, OFFSET intro_EC2
	call  WriteString
	call  CrLf
	mov   edx, OFFSET intro_EC3
	call  WriteString
	call  CrLf
	call  CrLf


main ENDP

END main