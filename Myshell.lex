%{
/* arquivo produzido pelo bison */
#include "Myshell.tab.h"
#include <stdio.h>
#include <string.h>
%}

%option noyywrap

%%

[0-9]+ { yylval.val = atoi(yytext);
             return(NUMBER);
           }

[0-9]+\.[0-9]+ {
             sscanf(yytext,"%f",&yylval.val);
             return(NUMBER);
           }

"ls"     return LS;
"ps"     return PS;
"+"      return '+';
"-"      return '-';
"*"      return '*';
"/"      return '/';
"calcula" return CC ;
"cd"      return CD ;
"kill"    return KL ;
"rmdir"   return RM;
"mkdir"   return MK;
"start"   return ST;
"touch"   return TC ;
"ifconfig" {system("ifconfig");}
[ \t]    ;
"\n"     return FIM_LINHA;
"quit"   return QT;

[a-zA-z]+ { strcpy(yylval.name,yytext);
            return (ID);
            }
".."      return ID ;
.         return ERROR ;
%%
