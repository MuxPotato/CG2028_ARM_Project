/*
 * convolve.s
 *
 *  Created on: 29/01/2023
 *      Author: Hou Linxin
 */
   .syntax unified
	.cpu cortex-m4
	.fpu softvfp
	.thumb

		.global convolve

@ Start of executable code
.section .text

@ CG2028 Assignment 1, Sem 2, AY 2023/24
@ (c) ECE NUS, 2024

@ Write Student 1’s Name here:
@ Write Student 2’s Name here:

@ You could create a look-up table of registers here:

@ R0 ...
@ R1 ...


@ Start of program. Check if this is correct for potential bug
@ R0 holds pointer to start address to signal array
@ R1 holds pointer to start address to kernel array
@ R2 holds M, signal size
@ R3 holds N, kernel size


@ R4 :
@ R5 :
@ R6 :
@ R7 :
@ R8 :
@ R9 :
@ R10:
@ R11:
@ R12:





@ write your program from here:

.lcomm resultArray, 256*4*16
.lcomm paddedSignal, 256*4*16
.lcomm flippedKernel, 256*4*16

convolve:
 	PUSH {R4-R11, LR}

	@ Task 1 Flipping of kernel from left to right and storing it into flippedKernel
	@ R4: flippedKernel address register
	@ R5: i variable used to count end condition of loop
	@ R6: Address of back iterator of kernel array
	@ R7: Value from back of kernel array, stored into front of flippedKernel array

	LDR R4, =flippedKernel

	MOV R6, #4
	MUL R6, R6, R3
	SUB R6, #4
	ADD R6, R1, R6


	MOV R5,#1
	@ count up from 1 to N inclusive.
	flip_loop:
		LDR R7, [R6], #-4
		STR R7, [R4], #4
		ADD R5, #1
		CMP R5, R3
		BLE flip_loop



	@ Task 2: Get padded signal, fill in N-1 extra zeros first into paddedArraySignal, then signal, then N-1 extra zeros again
	@ R2 holds M, signal size. Stop condition for loop_signal. R6 compares with R2
	@ R3: holds N, kernel size.
	@ R6: i variable used to count end condition of loop
	@ R7: N-1. used for end condition of loop. R6 checks against R7
	@ R9: paddedSignal address register
	@ R10: register holding 0 value
	@ R11: Address of signal array iterator
	MOV R6, #1
	MOV R7, R3
	SUB R7, #1

	LDR R9, =paddedSignal
	MOV R10, #0
	loop_zeros_1:
		STR R10, [R9], #4
		ADD R6, #1
		CMP R6, R7
		BLE loop_zeros_1

	MOV R6, #1
	MOV R11, R0
	loop_signal:
		LDR R12, [R11], #4
		STR R12, [R9], #4
		ADD R6, #1
		CMP R6, R2
		BLE loop_signal

	MOV R6, #1
	MOV R7, R3
	SUB R7, #1
	MOV R10, #0
	loop_zeros_2:
		STR R10, [R9], #4
		ADD R6, #1
		CMP R6, R7
		BLE loop_zeros_2



	@ Task 3: Calculating convolution
	@ R4: Address of first element of padded signal array
	@ R5: iterator j for mul_loop: goes from 1 to N kernel size every time.
	@ R6: iterator i
	@ R7: calc_loop: M + N - 1, for i to check when to stop.
	@	  mul_loop: holder for multiplication
	@ R8: resultArray address register
	@ R9: iterator address for signal array
	@ R10: iterator address for kernel array
	@ R11: sum of result so far for multiplication
	@ R12: holder for multiplication.


	@ Loop from 1 to M + N - 1, M + N - 1 is computed right before check, and placed into R7
	MOV R6,#1

	LDR R8, =resultArray

	calc_loop:

	@ Calculate starting address of padded signal array
	LDR R4, =paddedSignal
	MOV R9, #4
	MUL R9, R9, R6
	SUB R9, #4
	ADD R9, R9, R4
	@MOV R10, R1  @ CHANGED TO TRY
	LDR R10, =flippedKernel
	MOV R11, #0
	MOV R5, #1
		mul_loop:

		LDR R12, [R9], #4
		LDR R7, [R10], #4
		MUL R12, R7, R12
		ADD R11, R11, R12
		ADD R5, #1
		CMP R5, R3
		BLE mul_loop
	STR R11, [R8], #4
	ADD R6, #1
	ADD R7, R2, R3
	SUB R7, #1
	CMP R6,R7
	BLE calc_loop


	@ Set R0 to hold address of resultArray
	LDR R0, =resultArray
	POP {R4-R11, PC}


	@ main.c -> ASM -> subrountine
	@ As LR can only store one return address
	@ We are pushing R14, the return address for us to go back from ASM to main.c
	@ Into stack first, before going into the subrountine and replacing LR with
	@ the return address to the ASM main function.
	@ R14 is the LR -> Link Register
	@ So if we want to add more subrountines here, always preserve the return address
	@ (that is in R14), into the stack before going into that subrountine.
	@ R0-R3, R12 do not need to be PUSH and POP. bcs they are caller-saved
	@ R4-R11, R14 ARE NOT, u need to PUSH and POP. bcs they are callee-saved


	@BL SUBROUTINE

	@POP {R14}
	BX LR

SUBROUTINE:

	BX LR
