#include <avr/io.h>

.equ MISO, 6

.global main

main:
	ldi r17, 0x00
	sts DDRA, r17
	ldi r17, (1 << SPIE) | (1 << SPE) | (1 << CPOL)
	sts SPCR, r17
	ldi r17, (1 << MISO)
	sts DDRB, r17
	ldi r17, 0xFF
	sts PORTA, r17
	sts SPDR, r17
	SEI
	label:
		lds r17, PINA
	rjmp label

.global SPI_STC_vect
SPI_STC_vect:
	sts SPDR, r17
reti

.end
