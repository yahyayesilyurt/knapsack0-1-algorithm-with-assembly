; Constants (weight capacity and size)
W_Capacity	EQU	50 
SIZE	EQU	3

; writable data area for dp_arr
	AREA data, DATA, READWRITE
		ALIGN
dp_arr	SPACE W_Capacity * 4 ; allocate space for dp array (50 words)
dp_end

; code area (readonly)
	AREA iterative, CODE, READONLY
		ENTRY
		ALIGN
__main	FUNCTION
		EXPORT __main
		MOVS	R1, #W_Capacity	; R1 = W
		MOVS	R2, #SIZE	; R2 = n
		BL	knapSack ; Branch with link to knapSack
		B	stop	; Branch to infinite loop after return
		
stop	B	stop ; infinite loop for stop execution(while(1))

knapSack ; R1=W, R2=n	
		ADDS	R2, #1 ; R2 = n+1
		MOVS	R3, #1 ; R3 = i (initialize with 1)
		PUSH {LR}	; Save link register to stack
		B	L1 ; Branch to loop L1
		
L1		MOV	R4, R1 ; Set R4 = W
		CMP	R3, R2 ; Compare i (R3) with n+1 (R2)
		BGE	return_dp ; If i >= n+1, branch to return_dp
		B	L2 ; Otherwise, continue to loop L2
		
L2		CMP	R4, #0 ; Check if remaining capacity is 0
		BLT	inc_i ; If R4 < 0, increment i
		LDR	R5, =weight ; Load address of weight array into R5
		MOVS	R6, R3 ; Copy i to R6
		SUBS	R6, #1 ; R6 = i - 1
		LSLS	R6, #2 ; R6 = 4*(i - 1) to get address offset
		LDR	R5, [R5, R6] ; R5 = weight[i-1]
		CMP R4, R5 ; Compare W (R4) with weight[i-1]
		BLT	decr_w ; If W < weight[i-1], decrement W
		; Inside if (if R4 >= weight[i-1])
		MOV	R7, R4	; R7=w
		SUBS	R7, R5 ; R7 = w - weight[i-1]
		LDR	R5, =profit ; Load address of profit array into R5
		LDR	R5, [R5, R6] ; R5 = profit[i-1]
		LDR	R6, =dp_arr ; Load base address of dp array
		LSLS	R7, #2 ; Offset by 4 bytes (R7 * 4)
		LDR	R7, [R6, R7] ; R7 = dp[ w - weight[i - 1]]
		ADDS	R7, R5 ; R7 = dp[ w - weight[i - 1]] + profit[i - 1]
		PUSH	{R2} ; Save R2 to stack
		MOVS	R2, R7 ; Set R2 = R7 for comparison
		MOVS	R7, R4 ; Copy w to R7
		LSLS	R7, #2 ; R7 = w * 4 (offset in dp array)
		PUSH	{R1} ; Save R1 to stack
		LDR	R1, [R6, R7] ; R1 = dp[w]
		BL	compareR1andR2 ; Call (branch with link) compare function
		POP {R1}	; Restore R1 from stack
		POP {R2}	; Restore R2 from stack
		MOVS	R7, R4 ; R7 = w	
		LSLS	R7, #2	; Offset by 4 bytes
		STR	R0, [R6, R7]	; Store max result in dp[w]
		B	decr_w	; Continue to decrement W
		
compareR1andR2 ; Function to compare R1 and R2
		CMP	R1, R2 ; Compare R1 and R2
		BLT	saveR2toR0 ; If R1 < R2, set R0 = R2
		MOV	R0, R1 ; Otherwise, set R0 = R1
		MOV	PC, LR ; Return from function
		
saveR2toR0 ; Function to set R0 = R2
		MOV	R0, R2 ; Set R0 = R2
		MOV	PC, LR ; Return from function
		
		
inc_i	ADDS	R3, #1 ; Increment i
		B	L1 ; Continue loop L1
		
decr_w	SUBS	R4, #1 ; Decrement w
		B	L2	; Continue loop L2
		


return_dp ; Function to return dp array result
		LDR	R3, =dp_arr ; Load address of dp array into R3
		LSLS	R1, #2 ; R1 = W * 4 (for offset)
		LDR	R0, [R3, R1] ; Load dp[W] into R0 (result)
		LDR	R1, =profit	; Load address of profit array into R1
		LDR	R2, =weight	; Load address of weight array into R2
		LDR	R3, =dp_arr	; Reload address of dp array into R3
		POP {PC}	; Restore program counter to return
		BX	LR	; Branch to link register to end function
		
profit	DCD	60,100,120 ; Define profit array
p_end
weight	DCD	10,20,30	; Define weight array
w_end

		END	; End of program
		
	