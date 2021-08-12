%{ 
#include<stdio.h> 
int id = 0,op = 0; 
int top = -1; 
char stack[10]; 
%} 
%% 
[+] {op++;printf("%s is an operator\n",yytext);} 
[*] {op++;printf("%s is an operator\n",yytext);} 
[\-] {op++;printf("%s is an operator\n",yytext);} 
[/] {op++;printf("%s is an operator\n",yytext);} 
[0-9]+ {id++;printf("%s is an identifier\n",yytext);} 
[(] {stack[++top]='(';} 
[)] {if(stack[top]=='(') 
top--; 
else 
{
printf("This is invalid expression\n"); 
exit(0);} 
} 
%% 
int main() 
{ 
printf("Enter the expression: \n"); 
yylex(); 
if(top!=-1||op>=id||id==1) 
{ 
printf("Invalid Expression\n"); 
return 0; 
} 
else 
{ 
printf("Valid Expression\n"); 
printf("Identifier count = %d\nOperator count = %d\n",id,op); } 
return 0; 
}

-------------method 2-------------------

%{ 
#include<stdio.h> 
int br=0, id=0,op=0; 
%} 
%x OPR 
%% 
[0-9]+ {BEGIN(OPR);id++;printf("%s is an identifier\n",yytext);} 
[\t\n]+ 
"(" {br++;} 
[^0-9]+ {printf("Invalid expression\n");exit(0);} 
<OPR>[+\-*/] {BEGIN(0);op++;printf("%s is an operator\n",yytext);} 
<OPR>[ \t\n]+ 
<OPR>")" {br--;} 
<OPR><<EOF>> {return 0;}
<OPR>. {printf("Invalid expression\n");exit(0);} 
%% 
int main() 
{ 
printf("Enter the expression: \n"); 
yylex(); 
if(br!=0) 
{ 
printf("Invalid Expression\n"); 
return 0; 
} 
else 
{ 
printf("Valid Expression\n"); 
printf("Identifier count = %d\noperator count = %d\n",id,op); } 
return 0; 
} 
