%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>
unsigned charCount = 0, lineCount = 1;
#define typeNum 8
#define MAX_BUF_SIZE 1024
char *type[typeNum] = { "integer", "real", "ID", "reserved word", "string", "symbol", "comment", "Unrecognized character" };
char *prevToken;
char buf[MAX_BUF_SIZE];
int declaration = 0;
int state = 1;
int rcmp( char* a, int a_len, const char* b, int b_len )
{
	if( a_len == b_len )
	{
		a_len--;
		while( a_len >= 0 )
		{
			if( tolower( a[a_len] ) != tolower( b[a_len] ) )
				return 1;
			a_len--;
		}
		return 0;
	}
	return 1;
}

%} 
ID	[a-zA-Z_][_a-zA-Z0-9]*
reserved (?i:and)|(?i:array)|(?i:asm)|(?i:begin)|(?i:break)|(?i:case)|(?i:const)|(?i:constructor)|(?i:continue)|(?i:destructor)|(?i:div)|(?i:do)|(?i:downto)|(?i:end)|(?i:false)|(?i:file)|(?i:for)|(?i:function)|(?i:implementation)|(?i:in)|(?i:inline)|(?i:interface)|(?i:label)|(?i:mod)|(?i:nil)|(?i:not)|(?i:object)|(?i:of)|(?i:on)|(?i:operator)|(?i:or)|(?i:packed)|(?i:procedure)|(?i:program)|(?i:record)|(?i:repeat)|(?i:set)|(?i:shl)|(?i:shr)|(?i:then)|(?i:to)|(?i:true)|(?i:type)|(?i:unit)|(?i:until)|(?i:uses)|(?i:var)|(?i:with)|(?i:xor)|(?i:as)|(?i:class)|(?i:dispose)|(?i:expect)|(?i:exit)|(?i:exports)|(?i:finalization)|(?i:finally)|(?i:inherited)|(?i:initialization)|(?i:is)|(?i:library)|(?i:new)|(?i:on)|(?i:out)|(?i:property)|(?i:raise)|(?i:self)|(?i:threadvar)|(?i:try)|(?i:integer)|(?i:real)|(?i:unit)|(?i:byte)|(?i:single)|(?i:double)|(?i:shortint)|(?i:smallint)|(?i:word)|(?i:cardinal)|(?i:longint)|(?i:longword)|(?i:string)|(?i:boolean)|(?i:char)|(?i:float)
funcst	(?i:read)|(?i:write)|(?i:while)|(?i:goto)|(?i:if)|(?i:else)
endl	[\n]
comment	[\(][\*]
string 	[\']
integer	[\+\-]?[0-9]+
symbol	[\+\-\*\/\=\<\>\[\]\.\,\(\)\:\^\@\{\}\$\#\&\%\;]|"<<"|">>"|"<>"|"><"|"<="|">="|":="|"+="|"-="|"*="|"/="|"(."|".)"|"//"
real	{integer}([\.][0-9]+)?([Ee]{integer})?
other	.	
space	[ \t]
ignore	[\r]
cmterr	"*)"
%%
{endl}		{ 
				if( state != 1 && state != 4 )
					printf("Line: %u, 1st char: %u, expect a “';'”.\n", lineCount, charCount + 1 );					
				state = 1;
				lineCount++; 
				charCount = 0;
			}
{funcst}	{
				if( state == -1 || state == -2 )
				{
					strcat( buf, yytext );
				}
				else
				{
					state = 2;
					printf("Line: %u, 1st char: %u, “%s” is a “%s”.\n", lineCount, charCount + 1, yytext, type[3] ); 
					charCount += yyleng; 
					prevToken = type[3];	
				}
			}
{reserved}	{
				if( state == -1 || state == -2 )
				{
					strcat( buf, yytext );
				}
				else if( rcmp( yytext, yyleng, "var", 3 ) == 0 )
				{
					declaration = 1;
					memset( buf, 0, MAX_BUF_SIZE );
				}
				else if( rcmp( yytext, yyleng, "begin", 5 ) == 0 )
				{
					declaration = 0;
					state = 1;
				}
				else if( rcmp( yytext, yyleng, "end", 3 ) == 0 )
					state = 4;
				else if( ( rcmp( yytext, yyleng, "then", 4 ) == 0 ) || ( rcmp( yytext, yyleng, "do", 2 ) == 0 ) )
					state = 1; 
				printf("Line: %u, 1st char: %u, “%s” is a “%s”.\n", lineCount, charCount + 1, yytext, type[3] ); 
				charCount += yyleng; 
				prevToken = type[3];
			}
{cmterr}	{
				if( state == -1 )
				{
					printf("“%s” is an invalid “%s”.\n", buf, type[2] );
				}
				else if ( state == -2 )
				{
					printf("“%s” is an invalid “%s”.\n", buf, type[1] );
				}
				printf("Line: %u, 1st char: %u, “%s” is an invalid “%s”.\n", lineCount, charCount + 1, yytext, type[6] ); 
				charCount += yyleng;
				state = 4;
			}
{comment}	{	
				int c, temp_i = 0, temp_i1 = 0; memset( buf, 0, MAX_BUF_SIZE );
				while( 1 )
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
							charCount += ( yyleng + temp_i1 );
							lineCount += temp_i;
							prevToken = type[6];
							break;
						}
					}
					if( c == EOF )
					{
						printf( "EOF in comment" );
						break;
					}
				}
			}			
{integer} 	{ 
				if( state == 1 )
				{
					printf("Line: %u, 1st char: %u, ", lineCount, charCount + 1 );
					memset( buf, 0, MAX_BUF_SIZE );
					strcat( buf, yytext );
					state = -1;
				}
				else if( state == -1 || state == -2 )
				{
					strcat( buf, yytext );
				}
				else if( prevToken == type[0] && ( yytext[0] == '+' || yytext[0] == '-' ) )
				{
					REJECT;			
				}
				else
				{
					memset( buf, 0, MAX_BUF_SIZE );
					strcat( buf, yytext );
					int c = input();
					if( c == '.' )
					{
						printf("Line: %u, 1st char: %u, ", lineCount, charCount + 1 );
//						memset( buf, 0, MAX_BUF_SIZE );
//						strcat( buf, yytext );
						state = -2;
					}
					else
					{
						unput( c );
						printf("Line: %u, 1st char: %u, “%s” is a “%s”.\n", lineCount, charCount + 1, buf, type[0] ); 
						prevToken = type[0];
					}
				}
				charCount += yyleng; 
			}
{real}		{ 
				if( prevToken == type[0] && ( yytext[0] == '+' || yytext[0] == '-' ) )
				{
					REJECT;			
				}
				else if( state == -1 || state == -2 )
				{
					strcat( buf, yytext );
				}
				
				if( yytext[yyleng - 1] == '0' )
					printf("Line: %u, 1st char: %u, “%s” is an invalid “%s”.\n", lineCount, charCount + 1, yytext, type[1] );
				else
					printf("Line: %u, 1st char: %u, “%s” is a “%s”.\n", lineCount, charCount + 1, yytext, type[1] ); 
				charCount += yyleng;
				prevToken = type[1];
			}
{symbol}	{ 	
				if( ( state == 1 ) )
				{

					printf("Line: %u, 1st char: %u, ", lineCount, charCount + 1 );
					memset( buf, 0, MAX_BUF_SIZE );
					strcat( buf, yytext );
					state = -1;
					
				}
				else if( state == -1 || state == -2 )
				{
					strcat( buf, yytext );
				}
				else if( strcmp( yytext, "." ) == 0 )
				{
					int c = input(), temp_i = 0;
					if( c <= '9' && c >= '0' || c == 'E' || c == 'e' )
					{
						memset( buf, 0, MAX_BUF_SIZE );
						while( c <= '9' && c >= '0' )
						{
							buf[temp_i] = c;
							c = input();
						}
						printf("Line: %u, 1st char: %u, “%s%s” is an invalid “%s”.\n", lineCount, charCount + 1, yytext, buf, type[1] ); 
					}
					else					
					{
						printf("Line: %u, 1st char: %u, “%s” is a “%s”.\n", lineCount, charCount + 1, yytext, type[5] ); 
						prevToken = type[5];
					}
					unput( c );	
				}	
				else 	
				{
					if( ( ( strcmp( yytext, ":" ) == 0 ) || ( strcmp( yytext, ":=" ) == 0 ) ) && ( state == 2 ) )
						state = 3;
					if( strcmp( yytext, ";" ) == 0 )
						state = 1;
					printf("Line: %u, 1st char: %u, “%s” is a “%s”.\n", lineCount, charCount + 1, yytext, type[5] ); 
					prevToken = type[5];
				}
				charCount += yyleng;
			}
{string}	{
				int c, len = 0, temp_i = 0;
				memset( buf, 0, MAX_BUF_SIZE );
				while( c = input() )
				{
					buf[temp_i++] = c;
					if( c == '\'' )
					{
						c = input();
						if( c == '\'' )
						{
							buf[temp_i++] = c;
						}
						else
						{
							if( len > 30 )
							{
								printf("Line: %u, 1st char: %u,“%s%s” is an invalid “%s”\n", lineCount, charCount + 1, yytext, buf, type[4] );
								break;
							}
							printf("Line: %u, 1st char: %u, “%s%s” is a “%s”.\n", lineCount, charCount + 1, yytext, buf, type[4] ); 
							prevToken = type[4];
							break;
						}
					}
					else if( c == '\n' || c == '\r' )
					{
						if( c == '\n' )
							state = 1;
						else
							state = 4;
						buf[--temp_i] = '\0';
						printf("Line: %u, 1st char: %u, “%s%s” is an invalid “%s”.\n", lineCount, charCount + 1, yytext, buf, type[4] ); 
						break;
					}
					len++;
				} 
				unput( c );
				charCount += ( temp_i + 1 );
			}
{space} 	{	
				if( state == -1 )
				{
					printf("“%s” is an invalid “ID”.\n", buf );
					state = 3;
				}
				charCount += yyleng;
			}
{ID}		{ 
				if( state == -1 || state == -2 )
					strcat( buf, yytext );
				else
				{
					if( state == 1 )
						state = 2;
					if( yyleng > 30 )
						printf("Line: %u, 1st char: %u, “%s” is an invalid “%s”.\n", lineCount, charCount + 1, yytext, type[2] ); 
					else					
						printf("Line: %u, 1st char: %u, “%s” is a “%s”.\n", lineCount, charCount + 1, yytext, type[2] ); 
					prevToken = type[2];
				}
				charCount += yyleng;
			}
{ignore}	{};
{other}		{ charCount++; printf("\n>(-_-)<\n>(-_-)< line no.%-5u : type = %s , \n>(-_-)< \t\tcharecter = %u\n>(-_-)<\n\n", lineCount, type[7], (unsigned)yytext[0] );}
%%
main(){  
	yylex(); 
	return 0;
}
