//---------------------------yacc code ----------------------------

%{ 
#include<stdio.h> 
#include<stdlib.h> 
%} 
%token A B 
%% 
str:S '\n' {return 0;} 
S:A S
|A B; 
%% 
int main() 
{ 
printf("Enter the string:\n"); 
yyparse(); 
printf("Valid String\n"); 
return 0; 
} 
yyerror() 
{ 
printf("Invalid expression\n"); 
exit(0); 
} 


//-----------------------lex code----------------------------------------

%{ 
#include"y.tab.h"
%} 
%% 
a return A; 
b return B; 
. return yytext[0]; 
\n return yytext[0]; 
%% 
int main() 
{ 
printf("Enter the string:\n"); 
yyparse(); 
printf("Valid String\n"); 
return 0; 
} 
yyerror() 
{ 
printf("Invalid expression\n"); 
exit(0); 
}