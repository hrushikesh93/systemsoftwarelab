//-----------------------yacc code---------------------------------

%{

        #include<stdio.h>
        #include<stdlib.h> 
        int id=0,key=0,op=0;
%}
%token ID KEY OP

%%

input:ID input {++id;}
     |KEY input {++key;}
     |OP input {++op;}
     |ID {++id;} 
     |KEY {++key;}
     |OP {++op;}
     ;
;

(a<b)

if ( --> op input ;
if a --> id input;
if < --> op input;
if b -->
%%

extern FILE *yyin; 
void main()
{
        yyin = fopen("abc.c","r");
        yyparse();
        printf("Keywords=%d\n",key); 
        printf("Identifiers-%d\n", id);
        printf("Operators=%d\n",op);
}
void yyerror()
{
        printf("Error"); 
        exit(0);
}        

//----------------------------lex code------------------------------

%{
        #include<stdio.h>
        #include"y.tab.h"
%}

%%
"#".*\n
[+|\-|\*|\/|=|<|>|(|)|{|}|] {printf("Operator is:%s\n",yytext);return OP;}
int|char|bool|float|void|if|else|return|break|continue|printf|scanf|double|main {printf("Keyword is:%s\n",yytext);return KEY;}
_?[a-z|A-Z]_?[a-z|A-Z|0-9]* {printf("Identifier is:%s\n",yytext); return ID;}
.

%%

//-----------------------------6b.c---------------------------------

#include<stdio.h>
int main()
{
int a=7,b=5,c=5;
c=a+b;
printf("sum = %d",c);
return 0;
}
