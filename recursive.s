	AREA recursive, CODE, READONLY ; Code field definition (read-only)
		ENTRY ; Starting point of the program
		
		ALIGN ; Ensures code alignment
__main FUNCTION 
	EXPORT __main ; exposes the __main function to the outside
	LDR R1, =profit ; Load the address of the profit array into register R1
	LDR R2, =weight ; Load the address of the weight array into register R2
	LDR R3, =W_Capacity ; Load maximum capacity into register R3
	LDR R4, =SIZE ; Load the number of elements into register R4
	BL knapSack ; call knapSack function, store result in R0
	

stop B stop ; Infinite loop, returns here continuously with while tag
	
	ALIGN ; Ensures code alignment
	ENDFUNC ; Indicates the end of the function
	
; max function, compares two values and returns the maximum	
max PROC
	CMP R6, R5 ; Compare registers R6 and R5
	BLE return_r ; If R6 <= R5 then go to return_r label
	MOV R0, R6 ; If R6 is greater, load R6 into R0
	BX LR ; return max function

return_r
	MOV R0, R5 ; If R5 is greater, load R0 with the value of R5
	BX LR ; return max function
	ENDP ; end of max function
	
; knapSack function	
knapSack PROC
	PUSH {LR} ; store LR on stack (save return address)
	PUSH {R3, R4, R5, R6, R7} ; Save registers R3-R7 to stack (for local variables)
	
	CMP R3, #0 ; Compare R3 (capacity) with 0
	BEQ knapSack_return_0 ; If capacity is 0 go to knapSack_return_0 tag
	CMP R4, #0 ; Compare R4 (number of items) with 0
	BEQ knapSack_return_0 ; If items run out go to tag knapSack_return_0
	
	SUBS R4, #1 ; Decrease R4 by 1 (we are considering an element)
	MOV R7, R4 ; Load the value of R4 into R7
	LSLS R7, #2 ; Multiply R7 by 4 (to access 4 byte elements)
	LDR R7, [R2, R7] ; Get the weight in R7 from the weight array
	CMP R7, R3 ; Check if the weight is greater than the capacity
	BHI ifcond ; If weight is greater than capacity go to ifcond tag
	B elsecond ; If the weight is not suitable go to elsecond tag
	
ifcond
	BL knapSack ; call knapSack function, return value in R0
	B knapSack_end ; jump to knapSack_end
	
elsecond
	BL knapSack ; call knapSack function again, store the return value in R0
	MOV R5, R0 ; Load the value returned by knapSack into R5 (without including the element)
	SUBS R3, R7 ; Subtract R7 from R3 (subtract weight from capacity)
	BL knapSack ; call knapSack function again
	
	MOV R7, R4 ;Restore R4 to R7
	LSLS R7, #2 ; Multiply R7 by 4 (to access 4 byte elements)
	LDR R7, [R1, R7] ; Get the profit in R7 from the profit array
	ADD R7, R0 ; Add profit to the value returned by knapSack
	MOV R6, R7 ; Load total profit to R6
	BL max ; call max function, load maximum into R0
	B knapSack_end ; jump to knapSack_end
	
	
knapSack_return_0
	MOVS R0, #0 ; set R0 to 0 (if capacity or number of elements is zero)
	
	
knapSack_end
	POP {R3, R4, R5, R6, R7} ; Restore registers R3-R7
	POP{PC} ; load PC from stack (returns)
	ENDP ; end of knapSack function

; Data Area
W_Capacity EQU 50 ; Maximum capacity (fixed value 50)
SIZE EQU 3 ; Number of elements (3 elements)
profit DCD 60, 100, 120 ; profit values
weight DCD 10, 20, 30 ; weight values
	END ; End of the program
	