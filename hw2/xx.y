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
lines: lines expression '\n' { printf("answer=%lf\n",$2); }
		| {} 
		;
expression: expression '+' expression 
		{$$ = $1+$3;printf("$$ = %lf\n",$$);}
		| expression '-' expression 
		{$$ = $1-$3;}          
		| expression '*' expression 
		{$$ = $1*$3;}
		| expression '/' expression 
		{ if($3 == 0)yyerror("divide by zero");
		  else  
		      $$ = $1/$3;                 
		}          
		|'-' expression %prec UMINUS 
		{$$ = -$2;}          
		| '(' expression ')'  {$$ = $2;}           
		| NUMBER {$$ = $1;}
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