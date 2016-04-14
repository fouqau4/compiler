%{
#include<stdio.h>
#include<ctype.h>
unsigned charCount = 0, idCount = 0, lineCount = 1;
#define typeNum 8
#define commentSize 1024
char *type[typeNum] = { "integer", "real", "ID", "reserved word", "string", "symbol", "comment", "Unrecognized character" };
char *prevToken;

/*
v integer
v real
v ID
v reserve word
string
symbol
comment
*/
%} 
ID	[a-zA-Z_][_a-zA-Z0-9]{0,29}
reserved_word (?i:and)|(?i:array)|(?i:asm)|(?i:begin)|(?i:break)|(?i:case)|(?i:const)|(?i:constructor)|(?i:continue)|(?i:destructor)|(?i:div)|(?i:do)|(?i:downto)|(?i:else)|(?i:end)|(?i:false)|(?i:file)|(?i:for)|(?i:function)|(?i:goto)|(?i:if)|(?i:implementation)|(?i:in)|(?i:inline)|(?i:interface)|(?i:label)|(?i:mod)|(?i:nil)|(?i:not)|(?i:object)|(?i:of)|(?i:on)|(?i:operator)|(?i:or)|(?i:packed)|(?i:procedure)|(?i:program)|(?i:record)|(?i:repeat)|(?i:set)|(?i:shl)|(?i:shr)|(?i:string)|(?i:then)|(?i:to)|(?i:true)|(?i:type)|(?i:unit)|(?i:until)|(?i:uses)|(?i:var)|(?i:while)|(?i:with)|(?i:xor)|(?i:as)|(?i:class)|(?i:dispose)|(?i:expect)|(?i:exit)|(?i:exports)|(?i:finalization)|(?i:finally)|(?i:inherited)|(?i:initialization)|(?i:is)|(?i:library)|(?i:new)|(?i:on)|(?i:out)|(?i:property)|(?i:raise)|(?i:self)|(?i:threadvar)|(?i:try)|(?i:integer)|(?i:read)|(?i:write)
endl	[\n]
comment	[\(][\*]
string 	[\']([^\n]|[\'][\']){0,30}[\']
integer	[\+\-]?[0-9]+
symbol	[\*\/\=\<\>\[\]\.\,\(\)\:\^\@\{\}\$\#\&\%\;]|"<<"|">>"|"**"|"<>"|"><"|"<="|">="|":="|"+="|"-="|"*="|"/="|"(*"|"*)"|"(."|".)"|"//"
real	{integer}([\.][0-9]+)?([Ee]{integer})?
other	.	
space	[ ]
ignore	[\r\t]
%%
{endl}		{ 
			lineCount++; 
			charCount = 0;
		}
{reserved_word}	{ 
			printf("Line: %u, 1st char: %u, “%s” is a “%s”.\n", lineCount, charCount + 1, yytext, type[3] ); 
			charCount += yyleng; 
			prevToken = type[3];
		}
{comment}	{	int c, temp_i = 0, temp_i1 = 0; char buf[commentSize];
			for( ; ; )
			{
				while( (c = input()) != '*' && c!= EOF )
				{
					buf[temp_i1] = c;
					temp_i1++;
					if( c == '\n' )
						temp_i++;
				}
				if( c == '*' )
				{
					buf[temp_i1] = c;
					temp_i1++;
					while( ( c = input() ) == '*' )
					{
						buf[temp_i1] = c;
						temp_i1++;
					}
					if( c == ')' )
					{
						buf[temp_i1] = c;
						temp_i1++;
						buf[temp_i1] = '\0';
						printf("Line: %u, 1st char: %u, “%s%s” is a “%s”.\n", lineCount, charCount + 1, yytext, buf, type[6] ); 
						charCount += yyleng;
						lineCount += temp_i;
						prevToken = type[6];
						break;
					}
				}
				if( c == EOF )
				{
					perror( "EOF in comment" );
					break;
				}
			}
		}
"+"|"-"		{
			printf("Line: %u, 1st char: %u, “%s” is a “%s”.\n", lineCount, charCount + 1, yytext, type[5] ); 
			charCount += yyleng; 
			prevToken = type[5];
		}			
{integer} 	{ 
			if( prevToken == type[0] && ( yytext[0] == '+' || yytext[0] == '-' ) )
			{
				printf("%s\n",yytext);
				REJECT;			
			}
			printf("Line: %u, 1st char: %u, “%s” is a “%s”.\n", lineCount, charCount + 1, yytext, type[0] ); 
			charCount += yyleng; 
			prevToken = type[0];
		}
{symbol}	{ 				
			printf("Line: %u, 1st char: %u, “%s” is a “%s”.\n", lineCount, charCount + 1, yytext, type[5] ); 				charCount += yyleng;
			prevToken = type[5];
		}
{real}		{ 
			printf("Line: %u, 1st char: %u, “%s” is a “%s”.\n", lineCount, charCount + 1, yytext, type[1] ); 
			charCount += yyleng;
			prevToken = type[1];
		}
{string}	{ 
			printf("Line: %u, 1st char: %u, “%s” is a “%s”.\n", lineCount, charCount + 1, yytext, type[4] ); 
			charCount += yyleng;
			prevToken = type[4];
		}
{space} 	{	
			charCount += yyleng;
		}
{ID}		{ 
			printf("Line: %u, 1st char: %u, “%s” is a “%s”.\n", lineCount, charCount + 1, yytext, type[2] ); 
			charCount += yyleng;
			prevToken = type[2];
		}
{ignore}	{};
{other}		{ charCount++; printf("\n>(-_-)<\n>(-_-)< line no.%-5u : type = %s , \n>(-_-)< \t\tcharecter = %s\n>(-_-)<\n\n", lineCount, type[7], yytext );}
%%
main(){  
	yylex(); 
	printf("%d %d %d\n", charCount, idCount, lineCount );
	return 0;
}
