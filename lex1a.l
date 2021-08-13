%{

#include<stdio.h>
int id=0,op=0,top=-1;
char stack[10];

%}

%%

[+]             {op++;printf("%s is an operator\n",yytext);}
[*]             {op++;printf("%s is an operator\n",yytext);}
[\-]    {op++;printf("%s is an operator\n",yytext);}
[/]     {op++;printf("%s is an operator\n",yytext);}
[0-9]+  {id++;printf("%s is an identifier\n",yytext);}
[(]             {stack[++top]='(';}
[)]             {if(stack[top]=='(') top--; else{printf("invalid\n");exit(0);}}

%%
int main()
{
        printf("enter the expression\n");
        yylex();
        if(top!=-1 || op>=id || id==1)
        {
                printf("invalid\n");
                return 0;
        }
        else
        {
                printf("valid \n");
                printf("no of operators%d\n no of identifiers %d\n",op,id);
        }
        return 0;

-------------method 2-------------------

%{
#include <stdio.h>
int id=0,op=0,br=0;

%}

%x opr

%%

[0-9]+                  {BEGIN(opr);id++;printf("%s is an identifier\n",yytext);}
[ \t\n]+
"("                             {br++;}
[^0-9]+                 {printf("invalid \n"); exit(0);}
<opr>[+\-*/]    {BEGIN(0);op++;printf("%s is an operator\n",yytext);}
<opr>[ \t\n]+
<opr>")"                {br--;}
<opr><<EOF>>    {return 0;}
<opr>.                  {printf("invalid\n"); exit(0);}

%%

int main()
{
        printf("enter the expression\n");
        yylex();
        if(br!=0 || id==1)
        {
                printf("invalid\n");
        }
        else
        {
                printf("valid\n");
                printf("no of operators %d\nno of identifier %d\n ",op,id);
        }
        return 0;
}
