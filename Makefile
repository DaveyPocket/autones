# Makefile for recnes
SER = 40:21	#Last digits of serial number for programmer

all: main.out main.hex mkii

main.out: main.S
	avr-gcc -o main.out -mmcu=atmega644 -Wall main.S

main.hex: main.out
	avr-objcopy -v -O ihex main.out main.hex

fuse:
	sudo avrdude -p m644 -c avrispmkii -P usb:$(SER) -u -U lfuse:w:0xee:m -U hfuse:w:0xdf:m -U efuse:w:0xff:m

mkii:
	sudo avrdude -p m644 -c avrispmkii -P usb:$(SER) -u -U flash:w:main.hex

clean:
	rm *.out *.hex
