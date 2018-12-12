;====================================================================
; Main.asm file generated by New Project wizard
;
; Created:   Fri Dec 30 2016
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
.def data = r20
.org 0x00
jmp reset

reset:
	cli
	ldi r16, low(RAMEND)
	out SPL, r16
	ldi r16, high(RAMEND)
	out SPH, r16
	
	
	LDI R16, 0x00; Address: Low Byte
	LDI R17, 0x00; Address: High Byte 
	CALL eprom_read
	
	ldi r16, 0x00
	ldi r17, 0x10
	ldi data, 0x55
	call sram_write
	sei
	
sram_write:
	cli
	LDI R18, 0xFF
	OUT DDRA, R18  ; PORTA is Output 
	OUT DDRC, R18 ; PORTC is Output    
	OUT DDRD, R18 ; PORTD is Output   
	
	OUT PORTA, data 
	OUT PORTC, R16   
	OUT PORTD, R17 
	
	sbi PORTD, 5	; output disable=1
	cbi PORTD, 6	; Write Pin=0
	
	
	NOP   ; 1NOP=1Clock=125ns>tWLWH=20ns   
	SBI PORTD, 6  ; Write Pin=1  
	NOP   ;1NOP=1Clock=125ns>tDVWH=15ns 
	RET   

eprom_read:
	cli
	LDI R18, 0xFF   
	OUT DDRC, R18  ; PORTC is Output   
	
	OUT DDRD, R18  ; PORTD is Output    
	
	LDI R18, 0x00     
	OUT DDRA, R18  ; PORTA is Input   
	
	OUT PORTC, R16 
	out PORTD, r17
	
	cbi PORTD, 5	; output disable=0
	sbi PORTD, 6	; Write Pin=1
	NOP       ;6NOP=6Clocks=6*125ns ? tAVQV+1.5Clocks=450ns+1.5*125ns   
	NOP
	NOP   
	NOP   
	NOP   
	NOP   
	IN R0, PINA  
	RET 

Start:
      ; Write your code here
Loop:
      rjmp  Loop

;====================================================================