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

; Get first number
startBlock:									; Program will restart from here when requested
	call  CrLf
	mov   edx, OFFSET prompt_1
	call  WriteString
	call  ReadInt
	mov   num_1, eax

; Get second number
	mov   edx, OFFSET prompt_2
	call  WriteString
	call  ReadInt
	mov   num_2, eax
	call  CrLf
	call  CrLf

; Validate that the second number is less than the first
	mov   eax, num_1
	mov   ebx, num_2
	cmp   eax, ebx
	jl    errorBlock						; If validation fails, jump to block showing error message

; Calculate the sum
	mov   eax, num_1
	add   eax, num_2
	mov   result_sum, eax

; Calculate the difference
	mov   eax, num_1
	sub   eax, num_2
	mov   result_dif, eax

; Calculate the product
	mov   eax, num_1
	mov   ebx, num_2
	mul   ebx
	mov   result_mul, eax

; Calculate the quotient
	mov   eax, num_1
	cdq										; Remainder will go in EDX
	mov   ebx, num_2
	sub	  edx, edx
	div   ebx
	mov   result_div, eax

; Calculate the remainder
	mov   result_rem, edx

; Convert the quotient to floating point (rounded to .001)
	fld     EC3_conv
	fiadd   num_1
	fstp    EC3_num1
	fld     EC3_num1
	fidiv   num_2
	fstp    result_EC3
	fld     result_EC3
	fmul    round1
	frndint									; Round to integer
	fdiv    round2
	fst     result_EC3

; Display result message
	mov   edx, OFFSET show_res
	call  WriteString
	call  CrLf

; Display the calculated sum
	mov   eax, num_1
	call  WriteDec
	mov   edx, OFFSET show_sum
	call  WriteString
	mov   eax, num_2
	call  WriteDec
	mov   edx, OFFSET show_ans
	call  WriteString
	mov   eax, result_sum
	call  WriteDec
	call  CrLf

; Display the calculated difference
	mov   eax, num_1
	call  WriteDec
	mov   edx, OFFSET show_dif
	call  WriteString
	mov   eax, num_2
	call  WriteDec
	mov   edx, OFFSET show_ans
	call  WriteString
	mov   eax, result_dif
	call  WriteDec
	call  CrLf

; Display the calculated product
	mov   eax, num_1
	call  WriteDec
	mov   edx, OFFSET show_mul
	call  WriteString
	mov   eax, num_2
	call  WriteDec
	mov   edx, OFFSET show_ans
	call  WriteString
	mov   eax, result_mul
	call  WriteDec
	call  CrLf

; Display the calculated quotient
	mov   eax, num_1
	call  WriteDec
	mov   edx, OFFSET show_div
	call  WriteString
	mov   eax, num_2
	call  WriteDec
	mov   edx, OFFSET show_ans
	call  WriteString
	mov   eax, result_div
	call  WriteDec

; Display the calculated remainder
	mov   edx, OFFSET show_rem
	call  WriteString
	mov   eax, result_rem
	call  WriteDec
	call  CrLf

; EC #3: Display the calculated floating point division result (rounded to .001)
	mov   edx, OFFSET show_EC3
	call  WriteString
	mov	  edx, OFFSET result_EC3
	call  WriteFloat
	call  CrLf
	call  CrLf

; Ask user if they want to continue with another calculation
continueBlock:
	mov   edx, OFFSET prompt_3
	call  WriteString
	call  ReadInt
	mov   ebx, no_loop
	cmp	  eax, ebx
	jne   startBlock						; User wants to continue so jump to starting again

; Display goodbye message and exit
;goodbyeBlock:
	call  CrLf
	mov   edx, OFFSET goodbye
	call  WriteString
	call  CrLf
	exit									; Exit out to the operating system

; Display error & jump to goodbye as EC #2 validation was not met
errorBlock:
	mov   edx, OFFSET error_EC2
	call  WriteString
	call  CrLf
	call  CrLf
	jmp   continueBlock
main ENDP

END main