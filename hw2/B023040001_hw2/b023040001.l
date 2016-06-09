%{
/*
 * pascal.l
 *
 * lex input file for pascal scanner
 *
 * extensions: to ways to spell "external" and "->" ok for "^".
 */

#include <stdio.h>
#include <string.h>
#include "y.tab.h"


int start_of_string = 1;

int p = 1;

int c_pos = 0;

int line_no = 1;


%}

A       [aA]
B       [bB]
C       [cC]
D       [dD]
E       [eE]
F       [fF]
G       [gG]
H       [hH]
I       [iI]
J       [jJ]
K       [kK]
L       [lL]
M       [mM]
N       [nN]
O       [oO]
P       [pP]
Q       [qQ]
R       [rR]
S       [sS]
T       [tT]
U       [uU]
V       [vV]
W       [wW]
X       [xX]
Y       [yY]
Z       [zZ]
NQUOTE  [^']
       
%%

{A}{N}{D}                          {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(AND);}
{A}{R}{R}{A}{Y}                    {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(ARRAY);}
{C}{A}{S}{E}                       {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(CASE);}
{C}{O}{N}{S}{T}                    {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(CONST);}
{D}{I}{V}                          {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(DIV);}
{D}{O}                             {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(DO);}
{D}{O}{W}{N}{T}{O}                 {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(DOWNTO);}
{E}{L}{S}{E}                       {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(ELSE);}
{E}{N}{D}                          {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(END);}
{E}{X}{T}{E}{R}{N}        |
{E}{X}{T}{E}{R}{N}{A}{L}           {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(EXTERNAL);}
{F}{O}{R}                          {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(FOR);}
{F}{O}{R}{W}{A}{R}{D}              {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(FORWARD);}
{F}{U}{N}{C}{T}{I}{O}{N}           {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(FUNCTION);}
{G}{O}{T}{O}                       {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(GOTO);}
{I}{F}                             {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(IF);}
{I}{N}                             {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(IN);}
{I}{N}{T}{E}{G}{E}{R}		   	   {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(INT);}
{L}{A}{B}{E}{L}                    {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(LABEL);}
{M}{O}{D}                          {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(MOD);}
{N}{I}{L}                          {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(NIL);}
{N}{O}{T}                          {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(NOT);}
{O}{F}                             {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(OF);}
{O}{R}                             {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(OR);}
{O}{T}{H}{E}{R}{W}{I}{S}{E}        {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(OTHERWISE);}
{P}{A}{C}{K}{E}{D}                 {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(PACKED);}
{B}{E}{G}{I}{N}                    {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(PBEGIN);}
{F}{I}{L}{E}                       {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(PFILE);}
{P}{R}{O}{C}{E}{D}{U}{R}{E}        {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(PROCEDURE);}
{P}{R}{O}{G}{R}{A}{M}              {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(PROGRAM);}
{R}{E}{A}{D}					   {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(READ);}
{R}{E}{A}{L}					   {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(REAL);}
{R}{E}{C}{O}{R}{D}                 {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(RECORD);}
{R}{E}{P}{E}{A}{T}                 {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(REPEAT);}
{S}{E}{T}                          {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(SET);}
{T}{H}{E}{N}                       {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(THEN);}
{T}{O}                             {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(TO);}
{T}{Y}{P}{E}                       {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(TYPE);}
{U}{N}{T}{I}{L}                    {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(UNTIL);}
{V}{A}{R}                          {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(VAR);}
{W}{H}{I}{L}{E}                    {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(WHILE);}
{W}{I}{T}{H}                       {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(WITH);}
{W}{R}{I}{T}{E}                    {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(WRITE);}
[a-zA-Z]([a-zA-Z0-9\-])*           {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(IDENTIFIER);}

":="                               {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(ASSIGNMENT);}
'({NQUOTE}|'')+'                   {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(CHARACTER_STRING);}
":"                                {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(COLON);}
","                                {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(COMMA);}
[0-9]+                             {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(INTEGER);}
"."                                {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(DOT);}
".."                               {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(DOTDOT);}
"="                                {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(EQUAL);}
">="                               {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(GE);}
">"                                {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(GT);}
"["                                {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(LBRAC);}
"<="                               {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(LE);}
"("                                {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(LPAREN);}
"<"                                {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(LT);}
"-"                                {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(MINUS);}
"<>"                               {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(NOTEQUAL);}
"+"                                {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(PLUS);}
"]"                                {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(RBRAC);}
[0-9]+"."[0-9]+                    {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(REALNUM); }
")"                                {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(RPAREN);}
";"                                {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(SEMICOLON);}
"/"                                {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(DIV); }
"*"                                {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(STAR); }
"**"                               {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(STARSTAR); }
"->"                        	   {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(UPARROW); }
"^"                                {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext ); return(UPARROW); }

"(*"                        |
"{"                                { register int c;
                                     while ((c = input()))
                                     {
                                       if (c == '}')
                                         break;
                                       else if (c == '*')
                                       {
                                         if ((c = input()) == ')')
                                           break;
                                         else
                                           unput (c);
                                       }          
                                       else if (c == '\n')
                                         line_no++;
                                       else if (c == 0)
                                         commenteof();
                                     }
                                   }

[" "]                            {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext );   } ;
[\t]							 {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); c_pos += strlen( yytext );  } ;
[\f]							 {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); } ;
[\r]							 {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); } ;
\n                               {  if(start_of_string){printf("Line%3d: ", line_no ); start_of_string = 0;}if(p)printf("%s",yytext); line_no++; c_pos = 0; p = 1; start_of_string = 1; }

.                                { fprintf (stderr, "'%c' (0%o): illegal character at line %d, 1st char: %d\n", yytext[0], yytext[0], line_no, c_pos ); }

%%

commenteof()
{
  fprintf (stderr, "Unexpected EOF inside comment at line %d\n", line_no);
  exit (1);
}

yywrap ()
{
	return (1);
}

