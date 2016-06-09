%{

#include <stdio.h>
#include <string.h>
extern int line_no;
extern char *yytext;
extern int c_pos;
extern int p;

void yyerror(const char *); //syntax error時自動呼叫yyerror()
%}

%union{
char* name;
};
%token AND ARRAY ASSIGNMENT
%token CASE CHARACTER_STRING COLON COMMA CONST  
%token DIV DO DOT DOTDOT DOWNTO
%token ELSE END EQUAL EXTERNAL
%token FOR FORWARD FUNCTION
%token GE GOTO GT 
%token IDENTIFIER IF IN INT INTEGER
%token LABEL LBRAC LE LPAREN LT
%token MINUS MOD
%token NEWLINE NIL NOT NOTEQUAL
%token OF OR OTHERWISE
%token PACKED PBEGIN PFILE PLUS PROCEDURE PROGRAM
%token RBRAC READ REAL REALNUM RECORD REPEAT RPAREN
%token SEMICOLON SET SLASH STAR STARSTAR
%token THEN TO TYPE
%token UNTIL UPARROW
%token VAR
%token WITH WHILE WRITE

%define parse.error verbose

%%
prog: PROGRAM prog_name SEMICOLON VAR dec_list SEMICOLON PBEGIN stmt_list SEMICOLON END  DOT { puts(""); }
	;
//part I
prog_name: IDENTIFIER 
	| error 	  
	;

dec_list: dec
	| dec_list SEMICOLON dec  
	;
dec: id_list COLON type 
	| error 	  
	;

type: standtype 
	| arraytype
	;
standtype: INT 
	| REAL 
	|error 	  
	;
arraytype: ARRAY LBRAC INTEGER DOTDOT INTEGER RBRAC OF standtype
//	|error 	  
	;
id_list: IDENTIFIER 
	|id_list COMMA IDENTIFIER 	 
	|error 	  
	;
stmt_list: stmt 
	| stmt_list SEMICOLON stmt
	;
stmt: assign 
	| read 
	| write 
	| for 
	| ifstmt
	| error 	  
	;
assign: varid ASSIGNMENT simpexp 
	;
ifstmt: IF LPAREN exp RPAREN THEN body
//	|error 	  
	;
exp:  simpexp 
	| exp relop simpexp
//	| error 	  
	;
relop:	GT 
	| LT 
	| GE 
	| LE
	| NOTEQUAL
	| EQUAL	  
	;
simpexp: term 
	| simpexp PLUS term 
	| simpexp MINUS term
//	| error 	  
	;
term: factor 
	| term STAR factor 
	| term DIV factor 
//	| error 	  
	;
factor: varid 
	| INTEGER 
	| REAL 
	| LPAREN simpexp RPAREN
//	|error 	  
	;
read: READ LPAREN id_list RPAREN 
//	|error 	  
	;

write: WRITE LPAREN id_list RPAREN
//	|error 	  
	;
for: FOR index_exp DO body
//	|error 	  
	;
index_exp: varid ASSIGNMENT simpexp TO exp
	| error 	  
	;
varid: IDENTIFIER 
	| IDENTIFIER LBRAC simpexp RBRAC  
	| error 	  
	;
body: stmt
	| PBEGIN stmt_list SEMICOLON END
//	|error 	  
	;

%%
int main(){
yyparse(); //YACC透過yyparse()呼叫yylex()，並且開始做parsing
return 0;
}


void yyerror(const char *str)
{
	printf("\nLine %2d, 1st char:%3d, %s\n", line_no, c_pos, str );	
	p = 0;
}
/*
當發生syntax error的時候，
YACC預設會呼叫yyerror()，
而且傳入的參數為”syntax error”，
而預設只會把傳入的參數給印出來
(也就是印出”syntax error”)，
但我們可以定義自己的yyerror()。
*/
