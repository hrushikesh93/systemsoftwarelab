#include <stdio.h>
#include <stdlib.h>
#include <string.h>
char ip[15], stack[15];
int ip_ptr = 0, st_ptr = 0, len, i;
char temp[2], act[15];
void check()
{
int flag = 0;
while (1)
{
if (stack[st_ptr] == 'd' && stack[st_ptr - 1] == 'i')
{
stack[st_ptr - 1] = 'F';
stack[st_ptr] = '\0';
st_ptr--;
flag = 1;
printf("\n $%s\t\t%s$\t\tF->id", stack, ip);
}
if (stack[st_ptr] == ')' && stack[st_ptr - 1] == 'E' && stack[st_ptr - 2] == '(')
{
stack[st_ptr - 2] = 'F';
stack[st_ptr - 1] = '\0';
flag = 1;
st_ptr = st_ptr - 2;
printf("\n $%s\t\t%s$\t\tF->(E)", stack, ip);
}
if (stack[st_ptr] == 'F' && stack[st_ptr - 1] == '*' && stack[st_ptr - 2] == 'T')
{
stack[st_ptr - 1] = '\0';
st_ptr = st_ptr - 2;
flag = 1;
printf("\n $%s\t\t%s$\t\tT->T*F", stack, ip);}
else
{
if (stack[st_ptr] == 'F')
{
stack[st_ptr] = 'T';
flag = 1;
printf("\n $%s\t\t%s$\t\tT->F", stack, ip);
}
}
if (stack[st_ptr] == 'T' && stack[st_ptr - 1] == '+' && stack[st_ptr - 2] == 'E' && ip[ip_ptr] !=
'*')
{
stack[st_ptr - 1] = '\0';
st_ptr = st_ptr - 2;
flag = 1;
printf("\n $%s\t\t%s$\t\tE->E+T", stack, ip);
}
else
{
if ((stack[st_ptr] == 'T' && ip[ip_ptr] == '+') || (stack[0] == 'T' && ip[ip_ptr] == '\0') ||
(stack[st_ptr] == 'T' && ip[ip_ptr] == ')'))
{
stack[st_ptr] = 'E';
flag = 1;
printf("\n $%s\t\t%s$\t\tE->T", stack, ip);
}
}
if ((stack[st_ptr] == 'T' && ip[ip_ptr] == '*') ||
(stack[st_ptr] == 'E' && ip[ip_ptr] == ')') ||
(stack[st_ptr] == 'E' && ip[ip_ptr] == '+') ||
(stack[st_ptr] == '+' && ip[ip_ptr] == 'i' && ip[ip_ptr + 1] == 'd') ||
(stack[st_ptr] == '(' && ip[ip_ptr] == 'i' && ip[ip_ptr + 1] == 'd') ||
(stack[st_ptr] == '(' && ip[ip_ptr] == '(') ||
(stack[st_ptr] == '*' && ip[ip_ptr] == 'i' && ip[ip_ptr + 1] == 'd') ||
(stack[st_ptr] == '*' && ip[ip_ptr] == '(') ||
(stack[st_ptr] == '+' && ip[ip_ptr] == '('))
{
flag = 2;
}
if(!strcmp(stack,"E") && ip[ip_ptr]=='\0')
{
printf("\n $%s\t\t%s$\t\tACCEPT\n",stack,ip);
exit(0);}
if(flag==0)
{
printf("\n%s\t\t%s$\t\tREJECT\n",stack,ip);
exit(0);
}
if(flag==2)
return;
flag=0;
}
}
void main()
{
printf("\n SHIFT REDUCE PARSER \n");
printf("\n GRAMMAR \n");
printf("\n E -> E+T | T\n T -> T*F | F\n F -> (E) | id\n");
printf("\n Enter the input sentence : ");
scanf("%s",ip);
printf("\n\t Stack implementation table \n");
printf("\n Stack\t\tInput symbol\t\tAction ");
printf("\n______________________________________________________\n");
printf("\n $\t\t%s$\t\t--", ip);
strcpy(act,"shift ");
len = strlen(ip);
for (i = 0; i <= len - 1; i++)
{
if (ip[ip_ptr] == 'i' && ip[ip_ptr + 1] == 'd')
{
stack[st_ptr] = ip[ip_ptr];
st_ptr++;
ip[ip_ptr] = ' ';
ip_ptr++;
stack[st_ptr] = ip[ip_ptr];
stack[st_ptr + 1] = '\0';
ip[ip_ptr] = ' ';
ip_ptr++;
}
else
{
stack[st_ptr] = ip[ip_ptr];
stack[st_ptr + 1] = '\0';
ip[ip_ptr] = ' ';
ip_ptr++;}
printf("\n $%s\t\t%s$\t\t%s", stack, ip, act);
strcpy(act,"shift ");
if (ip[ip_ptr] == '(' || ip[ip_ptr] == '*' || ip[ip_ptr] == '+' || ip[ip_ptr] == ')')
{
temp[0] = ip[ip_ptr];
temp[1] = '\0';
}
else
{
temp[0] = ip[ip_ptr];
temp[1] = ip[ip_ptr + 1];
temp[2] = '\0';
}
strcat(act, temp);
check();
st_ptr++;
}
st_ptr++;
check();
}
