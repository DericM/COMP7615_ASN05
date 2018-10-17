#Deric Mccadden, A00751277
#2018-09-30

all: asm_io.o asn05.o
	gcc -m32 -o asn05 asn05.o driver.c asm_io.o

asm_io.o: asm_io.asm
	nasm -f elf32 -d ELF_TYPE asm_io.asm

asn05.o: asn05.asm
	nasm -f elf32 asn05.asm

clean:
	rm -f *.o
	rm -f asn05
