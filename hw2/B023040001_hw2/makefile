all: parser
	

parser: 
	bison -y -d b023040001.y;
	flex b023040001.l;
	gcc lex.yy.c y.tab.c -ly -lfl
	
clear:
	rm -f lex.yy.c y.tab.c y.tab.h  a.out *.o


#FLEX = /usr/bin/flex
#CFLAGS = -g
#LDLIBS = -lfl
#CC = /usr/bin/gcc
#BISON = /usr/bin/bison

#pascal:	b023040001.tab.o b023040001.lex.o
#	$(CC) -o b023040001_pascal b023040001.tab.o b023040001.lex.o $(LDLIBS)
#b023040001.lex.o:	b023040001.lex.c b023040001.tab.h
#	$(CC) -c b023040001.lex.c 
#b023040001.tab.o:	b023040001.tab.c b023040001.tab.h
#	$(CC) -c b023040001.tab.c 
#b023040001.tab.c:	b023040001.y
#	bison -d b023040001.y
#b023040001.lex.c:	b023040001.l
#	$(FLEX) b023040001.l
#	mv  lex.yy.c b023040001.lex.c

#clean:
#	rm  b023040001.tab.o b023040001.lex.o b023040001.tab.c pascal.lex.c b023040001.tab.h b023040001_pascal 
