//------------------lex code---------------------
// have to give a input .c file 

%{ 
#include<stdio.h> 
int c=0; 
%} 
%% 
"/*"[a-zA-Z0-9' '\t\n]+"*/" {c++; fprintf(yyout," ");} 
"//".* {c++; fprintf(yyout," ");} 
. {fprintf(yyout,"%s", yytext);} 
%% 
int main() 
{ 
yyin=fopen("abc.c","r"); 
yyout=fopen("xyz.c","w"); 
yylex(); 
printf("No. of comment lines = %d \n",c); 
return 0;
}


//------------------yacc code---------------------
// have to give a input .c file 


%{ 
#include<stdio.h> 
int c=0; 
%} 
%x MCOMMENT SCOMMENT
%% 
"/*" {BEGIN(MCOMMENT);} 
.|\n {fprintf(yyout,"%s", yytext);} 
<MCOMMENT>"*/" {BEGIN(0); c++;fprintf(yyout," ");} <MCOMMENT>.|\n ; 
<MCOMMENT><<EOF>> {printf("Error\n"); return 1;} "*/" {printf("Error\n"); return 1;} 
"//" {BEGIN(SCOMMENT);} 
<SCOMMENT>. ; 
<SCOMMENT>"\n" {BEGIN(0); c++; fprintf(yyout,"%s", yytext);} %% 
int main() 
{ 
yyin=fopen("abc.c","r"); 
yyout=fopen("xyz.c","w"); 
yylex(); 
printf("No. of comment lines = %d\n",c); 
return 0; 
} 
