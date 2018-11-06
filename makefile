#Deric Mccadden, A00751277
#2018-09-30

all: asm_io.o asn06.o
	gcc -m32 -o asn06 asn06.o driver.c asm_io.o

asm_io.o: asm_io.asm
	nasm -f elf32 -d ELF_TYPE asm_io.asm

asn06.o: asn06.asm
	nasm -f elf32 -l asn06.lst asn06.asm

clean:
	rm -f *.o
	rm -f asn06
