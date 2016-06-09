all: scanner
	
objects = b023040001.o
scanner: $(objects)
	gcc lex.yy.c -lfl
b023040001.o: b023040001.l
	flex b023040001.l
clear:
	rm -f lex.yy.c a.out
