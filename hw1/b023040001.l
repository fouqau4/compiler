%{
#include<stdio.h>
unsigned charCount = 0, idCount = 0, lineCount = 0;
/*
real
ID
reserve word
string
symbol
comment
*/
%} 
id	[^ \t\n]+
space	[ ]
eol	\n
character	.
integer	[\+\-]?[0-9]+
ID	[a-zA-Z_]([^[:space:]][_a-zA-Z0-9])*
real	[\+\-]?[0-9]+[.]?[eE][\+\-]?[0-9]+
%%
{real}	{ printf("This real is %s\n", yytext);}
{integer} { printf("This integer is %s\n", yytext);}
{space} {}
{ID}	{ idCount++; charCount += yyleng; printf("This id is %s\n", yytext);}

%%
main(){  
	yylex(); 
	printf("%d %d %d\n", charCount, idCount, lineCount );
	return 0;
}
