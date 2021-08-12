//-----------------------yacc code---------------------------------

%{ 
#include<stdio.h> 
#include<stdlib.h> 
int yylex(); 
int id=0,key=0,op=0; 
%} 
%token ID KEY OP 
%% 
input: ID input {++id;}
|KEY input {++key;} 
|OP input {++op;} 
|ID {++id;} 
|KEY {++key;} 
|OP {++op;} 
; 
%% 
extern FILE *yyin; 
int main() 
{ 
yyin=fopen("6b.c","r"); 
yyparse(); 
printf("id is%d \n key is %d \n op is %d\n",id,key,op); } 
int yyerror() 
{ 
printf("ERROR\n"); 
exit(0); 
} 

//----------------------------lex code------------------------------

%{ 
#include"y.tab.h" 
%} 
%% 
"<".*\n 
[+|-|*|/|=|<|>] {printf("operator is %s\n",yytext); return OP;} 
include|int|char|float|void|for|if|else|main|printf {printf("keyword is %s\n",yytext);  return KEY;} 
[_a-zA-Z]* {printf("Identifiers is %s\n",yytext); return ID;} 
"(".*")" 
. 
%% 
int main() 
{ 
yyin=fopen("6b.c","r"); 
yyparse(); 
printf("id is%d \n key is %d \n op is %d\n",id,key,op); } 
int yyerror() 
{ 
printf("ERROR\n"); 
exit(0); 
} 

//-----------------------------6b.c---------------------------------

%{ 
#include<stdlib.h> 
#include"y.tab.h" 
extern int yylval; 
%} 
%% 
[0-9]+ {yylval=atoi(yytext);return NUM;} 
[\t] ; 
\n return 0; 
. return yytext[0]; 
%% 
int main() 
{ 
yyin=fopen("6b.c","r"); 
yyparse(); 
printf("id is%d \n key is %d \n op is %d\n",id,key,op); } 
int yyerror() 
{ 
printf("ERROR\n"); 
exit(0); 
}
