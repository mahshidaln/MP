;====================================================================
; Main.asm file generated by New Project wizard
;
; Created:   Sat Nov 19 2016
; Processor: ATmega16
; Compiler:  AVRASM (Proteus)
;====================================================================

;====================================================================
; DEFINITIONS
;====================================================================

;====================================================================
; VARIABLES
;====================================================================

;====================================================================
; RESET and INTERRUPT VECTORS
;====================================================================

      ; Reset Vector
      rjmp  Start

;====================================================================
; CODE SEGMENT
;====================================================================

.org 0x00
	jmp rst_isr

rst_isr:
	CLI
	CLR  R16
	OUT  EECR,R16
	


start:
	ldi r16, (0 << PD3)
	out DDRD, r16
	ldi r16, (1 << PD5) 
	out DDRD, r16
	ldi r16, (1 << PD3)
	out PIND, r16
	ldi  r17,low(15)
	out  0x21,r17
while1:
	sbic 0x10,3
	rjmp off
	sbi 0x12,5
	wdr
off:
	rjmp while1
	jmp start



;====================================================================