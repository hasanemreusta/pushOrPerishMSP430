;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer



;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
 	BIS.B #BIT0, &P1DIR   ; Set P1.0 as output (Red LED)
    BIC.B #BIT0, &P1OUT   ; Ensure Red LED is off initially
    BIC.B #BIT3, &P1DIR   ; Set P1.3 as input (Button 1)
    BIS.B #BIT3, &P1REN   ; Enable pull-up/down resistor for P1.3
    BIS.B #BIT3, &P1OUT   ; Configure pull-up resistor on P1.3

    BIS.B #BIT1, &P2DIR ; Set P2.1 as output (Green LED)
    BIC.B #BIT1, &P2OUT ; Ensure Green LED is off initially
    BIC.B #BIT3, &P2DIR   ; Set P2.3 as input (Button 2)
    BIS.B #BIT3, &P2REN   ; Enable pull-up/down resistor for P2.3
    BIS.B #BIT3, &P2OUT   ; Configure pull-up resistor on P2.3



	bic.b #10111110b, &P1SEL ; make P1.1, 2, 3, 4, 5, and 7 Digital I/O
	bic.b #10111110b, &P1SEL2 ; make P1.1, 2, 3, 4, 5, and 7 Digital I/O
	bic.b #00000101b, &P2SEL ; make P2.0 and 2 Digital I/O
	bic.b #00000101b, &P2SEL2 ; make P2.0 and 2 Digital I/O
	bis.b #10110110b, &P1DIR ; make P1.1, 2, 4, 5, and 7 output
	bis.b #00000101b, &P2DIR ; make P2.0 and 2 output
	bic.b #BIT3, &P1DIR ; make P1.3 input
	bis.b #BIT3, &P1REN ; enable pull-up resistor for P1.3
	bis.b #BIT3, &P1OUT ; enable pull-up resistor for P1.3
	bis.b #10110110b, &P1OUT ; All segments OFF
	bis.b #00000101b, &P2OUT ; All segments OFF
initial:
	BIC.B #BIT0, &P1OUT   ; Ensure Red LED is off initially
	BIC.B #BIT1, &P2OUT ; Ensure Green LED is off initially
	bis.b #10110110b, &P1OUT ; All segments OFF
	bis.b #00000101b, &P2OUT ; All segments OFF
	call #show_3



show_1:
	bic.b #BIT2, &P1OUT ; Turn on b
	bic.b #BIT4, &P1OUT ; Turn on c
	call #delay
	bis.b #10110110b, &P1OUT ; All segments OFF
	bis.b #00000101b, &P2OUT  ; All segments OFF

	jmp show_0

show_2:
	bic.b #BIT1, &P1OUT ; Turn on a
	bic.b #BIT2, &P1OUT ; Turn on b
	bic.b #BIT5, &P1OUT ; Turn on d
	bic.b #BIT7, &P1OUT ; Turn on e
	bic.b #BIT2, &P2OUT ; Turn on g
	call #delay
	bis.b #10110110b, &P1OUT ; All segments OFF
	bis.b #00000101b, &P2OUT  ; All segments OFF
	jmp show_1

show_3:
	bic.b #BIT1, &P1OUT ; Turn on a
	bic.b #BIT2, &P1OUT ; Turn on b
	bic.b #BIT4, &P1OUT ; Turn on c
	bic.b #BIT5, &P1OUT ; Turn on d
	bic.b #BIT2, &P2OUT ; Turn on g
	call #delay
	bis.b #10110110b, &P1OUT ; All segments OFF
	bis.b #00000101b, &P2OUT ; All segments OFF
	jmp show_2

show_0:
	bic.b #BIT1, &P1OUT ; Turn on a
	bic.b #BIT2, &P1OUT ; Turn on b
	bic.b #BIT4, &P1OUT ; Turn on c
	bic.b #BIT5, &P1OUT ; Turn on d
	bic.b #BIT7, &P1OUT ; Turn on e
	bic.b #BIT0, &P2OUT ; Turn on f
	call #delay
	bis.b #10110110b, &P1OUT ; All segments OFF
	bis.b #00000101b, &P2OUT ; All segments OFF
	jmp show_

show_:
	bic.b #BIT2, &P2OUT ; Turn on g
	jmp MAIN_LOOP

MAIN_LOOP:
    BIT.B #BIT3, &P2IN   ; Check state of Button 2 (P2.3)
    JZ BUTTONPRESSED2
    BIT.B #BIT3, &P1IN   ; Check state of Button 1 (P1.3)
    JZ BUTTONPRESSED1
    JMP MAIN_LOOP
BUTTONPRESSED1:
	BIS.B #BIT0, &P1OUT  ; Turn on Red LED (P1.0)
	JMP reset_game
BUTTONPRESSED2:
	BIS.B #BIT1, &P2OUT ; Turn on Green LED (P2.1)
    	jmp reset_game
rule_2:
	BIT.B #BIT3, &P2IN   ; Check state of Button 2 (P2.3)
    JZ bt2_r2
	BIT.B #BIT3, &P1IN   ; Check state of Button 1 (P1.3)
    JZ bt1_r2
    ret
bt2_r2:
	bis.b #10110110b, &P1OUT ; All segments OFF
	bis.b #00000101b, &P2OUT ; All segments OFF
	bic.b #BIT2, &P2OUT ; Turn on g
	BIS.B #BIT0, &P1OUT  ; Turn on Red LED (P1.0)
	JMP reset_game
bt1_r2:
	bis.b #10110110b, &P1OUT ; All segments OFF
	bis.b #00000101b, &P2OUT ; All segments OFF
	bic.b #BIT2, &P2OUT ; Turn on g
	BIS.B #BIT1, &P2OUT ; Turn on Green LED (P2.1)
    jmp reset_game
delay2:
	mov.w #1000,r5
out_loop2:
	mov.w #750,r6
in_loop2:
	dec.w r6
	jnz in_loop2
	dec.w r5
	jnz out_loop2
	ret


delay:
	mov.w #500,r5
out_loop:
	mov.w #100,r6
in_loop:
	call #rule_2
	dec.w r6
	jnz in_loop
	dec.w r5
	jnz out_loop
	ret
reset_game:
	call #delay2
	jmp initial

end:
	nop







                                            

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
