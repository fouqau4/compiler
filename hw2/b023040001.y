%{
#include <stdio.h>
void yyerror(char *); //syntax error時自動呼叫yyerror()
//利用%union去定義token的type及yylval的值
%}
%union{
double dval;
};
%token <dval> NUMBER
%left '-' '+'//優先序的定義
%left '*' '/'//比+-還要高一級
%nonassoc UMINUS//表示没有结合性。它一般與%prec结合使用表示該操作有同樣的優先級。
%type <dval> expression

%%
prog: PROGRAM prog_name ';' VAR dec_list ';' BEGIN stmt_list ';' END '.'
	;
prog_name: id
	;
dec_list: dec 
	| dec_list ';' dec
	;
dec: id_list ':' type
	;
type: standtype 
	| arraytype
	;
standtype: INTEGER 
	| REALTYPE
	;
arraytype: ARRAY '['int .. int']' OF standtype
	;
id_list: id 
	| id_list ',' id
	;
stmt_list: stmt 
	| stmt_list ';' stmt
	;
stmt: 	assign 
	| read 
	| write 
	| for 
	| ifstmt
	;
assign: varid ":=" simpexp
	;
ifstmt: IF '(' exp ')' THEN body
	;
exp: simpexp | exp relop simpexp
	;
relop:	'>' 
	| '<' 
	| ">=" 
	| "<=" 
	| "<>" 
	| '='
	;
simpexp: term 
	| simpexp '+' term 
	| simpexp '-' term
	;
term:	 factor { '*' factor | DIV factor }
	;
factor: varid 
	| int 
	| real 
	| '(' simpexp ')'
	;
read: READ '(' id_list ')'
	;
write: WRITE '(' id_list ')'
	;
for: FOR index_exp DO body
	;
index_exp: varid ":=" simpexp TO exp
	;
varid: id | id '[' simpexp ']'
	;
body: stmt | BEGIN stmt_list ';' END
	;

%%
int main(){
yyparse(); //YACC透過yyparse()呼叫yylex()，並且開始做parsing
return 0;
}
void yyerror(char *str){ fprintf(stderr,"%s\n", str);}
/*
當發生syntax error的時候，
YACC預設會呼叫yyerror()，
而且傳入的參數為”syntax error”，
而預設只會把傳入的參數給印出來
(也就是印出”syntax error”)，
但我們可以定義自己的yyerror()。
*/
