;this program is to draw a circle or to find coordinates
;let the radius,r of circle be 100 units...stored in reg s21
;so in polar form p=rcosx q=rsinx
;I have calculated sinx in s0 reg and cosx in s13 reg 
;value of angle is in register S18..in degree 
  
  area     circle, CODE, READONLY
	   IMPORT printMsg1
	   IMPORT printMsg2		   
       EXPORT __main
       ENTRY 
__main  FUNCTION		 
        MOV R0, #11		          ;No. of itterations
		MOV R10, #2
        MOV R1 , #1		   		  	;for sin counter
		MOV R2 , #1				 	 ;for cos counter
		MOV R5 , #1
		
		VLDR.F32 S21,=100				; to store radius	
		VLDR.F32 S22,=1				;counter loop for theta
		VLDR.F32 S23,=10			; final value of counter theta
		
		;MOV R8 , #1            	  ; stores factorial 
		MOV R9 , #1 
		
		VLDR.F32 S24,=10			; difference of 10degrees
		VLDR.F32 S18,=0				; x in degree
		VLDR.F32 S19,=0.01745329252;
		VMUL.F32 S20,S18,S19;
		VMOV.F32 S0, S20;
        ;VLDR.F32 S0,=5.2359 		; result of sinx radian
		VMOV.F32 S1, S0;
		VMOV.F32 S2, S0;
		
		VLDR.F32 S6,=1		
		;VLDR.F32 S7,=2.2689
		VMOV.F32 S7, S0;
		VLDR.F32 S13,=1
		
		VLDR.F32 S17,=0
		VLDR.F32 S5,=0
		VLDR.F32 S15,=1
		VLDR.F32 S16,=2
		
		;VLDR.F32 S11,=2
		MOV R12 , #2 
		
		
		VLDR.F32 S3,=1       		;to calculate factorial 
		
		VLDR.F32 S6,=1 				 ;intermediate val
		B sinx

initial
		 ;MOV R0, #11
		; VLDR.F32 S15,=1
		;MOV R1 , #1	
		;MOV R2 , #1	
		;MOV R10, #2
		;MOV R9 , #1
		;B sinx
		
		
		MOV R0, #11		          ;No. of itterations
		MOV R10, #2
        MOV R1 , #1		   		  	;for sin counter
		MOV R2 , #1				 	 ;for cos counter
		MOV R5 , #1
		
		
		
		;MOV R8 , #1            	  ; stores factorial 
		MOV R9 , #1 
		
		
		VLDR.F32 S19,=0.01745329252;
		VMUL.F32 S20,S18,S19;
		VMOV.F32 S0, S20;
        ;VLDR.F32 S0,=5.2359 		; result of sinx radian
		VMOV.F32 S1, S0;
		VMOV.F32 S2, S0;
		
		VLDR.F32 S6,=1		
		;VLDR.F32 S7,=2.2689
		VMOV.F32 S7, S0;
		VLDR.F32 S13,=1
		
		VLDR.F32 S17,=0
		VLDR.F32 S5,=0
		VLDR.F32 S15,=1
		VLDR.F32 S16,=2
		
		;VLDR.F32 S11,=2
		MOV R12 , #2 
		
		
		VLDR.F32 S3,=1       		;to calculate factorial 
		
		VLDR.F32 S6,=1
		

sinx    					
		CMP R0, R1;
		beq cosx 
		ADD R9, R9,#2 
		B numerator
		

evenodd		
	   ; MOV R0, #7        ; Number to be check for even or odd R5
	    MOV R5, R10
        MOV R3, #2		   ; temperory reg to store 2
        udiv R6, R5, R3    ; udiv and mls instruction are used to perform modulus operation  
        MLS R6,R6, R3, R5  ; mod value stored in R6 it is either 0 or 1 since div by 2 
		CMP R6, #0         ; compared with 0
		BEQ subt
		BNE addition

fact
		VLDR.F S26,=1          ; for factorial
		B factorial
		
		
factorial					; to calculate factorial for denominator
		
		VMUL.F S26, S26, S27		;fact = fact* no.
		VSUB.F S27, S27, S15		;no.= no.-1
		VCMP.F S27, S17
		VMRS APSR_NZCV,FPSCR
		BGT factorial
        BLE divide 			; branch to divide

numerator 								; to prefor numerator of sin series
		VMUL.F32 S1,S1,S2;  t = t*x
		VMUL.F32 S1,S1,S2;
		B denominator					; branch to denominator of sin
		
denominator						; to calculate denominator of sine series
		MOV R7, R9
		VMOV.F S27,R7
		VCVT.F32.U32 S27,S27		
		B fact					; branch to calculate factorial
		
divide							; divide numerator and denominator of sine series
		 ;VMOV.F32 S3, R8;		
		 ;VCVT.F32.U32 S3,S3
		 VDIV.F32 S4,S1,S26		; sine value is calculated in s4 reg
		; VADD.F32 s0,s0,s4
		 ADD R1,R1,#1
		 B evenodd 
		 
addition 						; this block is for alternate addition and subtraction in sine series
		 VADD.F32 s0,s0,s4
		 ADD R10, #1
		 B sinx					;branch back to sin for next itteration
		 
subt
		VSUB.F32 s0,s0,s4
		ADD R10, #1
		B sinx					;branch back to sin for next itteration
		
		
		

cosx							; to calculate COS
		CMP R0, R2;				; for no. of itteration
		beq calp 				; branch to calculate tanx
		VADD.F32 S5,S16; 
		B numeratorcos			; branch to calculate numerator of cosx
		
numeratorcos					; to calculater numerator of cos series
		VMUL.F32 S6,S6,S7;  t = t*x
		VMUL.F32 S6,S6,S7;
		B denominatorcos
		
denominatorcos					; to calculate denominator of cos series
		VMOV.F32 S8, S5;
		B factcos
		
factcos
		VLDR.F S26,=1          ; for factorial
		B factorialcos
		

factorialcos		
		VMUL.F S26, S26, S8		;fact = fact* no.
		VSUB.F S8, S8, S15		;no.= no.-1
		VCMP.F S8, S17
		VMRS APSR_NZCV,FPSCR
		BGT factorialcos
        BLE dividecos

dividecos						; to finally divide numerator and denominator of cos
		VDIV.F32 S10,S6,S26
		ADD R2,R2,#1
		B evenoddcos 

evenoddcos						
	    MOV R5, R12
		;VCVT.F32.U32 S3,S3
        MOV R3, #2		   ; temperory reg to store 2
        udiv R6, R5, R3    ; udiv and mls instruction are used to perform modulus operation  
        MLS R6,R6, R3, R5  ; mod value stored in R1 it is either 0 or 1 since div by 2 
		CMP R6, #0         ; compared with 0  
		BEQ subtcos
		BNE additioncos

subtcos								;this block is for alternate addition and subtraction in cos series
		VSUB.F32 s13,s13,s10
		;VADD.F32 S11, S15
		ADD R12, #1
		B cosx
		
additioncos		
		 VADD.F32 s13,s13,s10
		 ;VADD.F32 S11, S15
		 ADD R12, #1
		 B cosx
		 
		 

calp
	VMUL.F32 S16,S0,S21 	;q=rsinx 
	VMOV.F32 R0, S16
	BL printMsg1
	VMUL.F32 S17,S13,S21	 ;p=rcosx	
	VMOV.F32 R0, S17
	BL printMsg2
	;VADD.F32 s22,s22,s15
	CMP R0, R2;
	beq nextval
	
nextval
	VCMP.F S22,S23
	VMRS APSR_NZCV,FPSCR
	BGE stop
	VADD.F32 S22,S22,S13
	VADD.F32 S18,S18,S24
	B initial	
	

stop B stop ; stop program
     ENDFUNC
     END
