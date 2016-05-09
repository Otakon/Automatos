%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(char * msg);
%}

%union { float val ;
         }
%union { char name[1024];
}

%token FIM_LINHA
%token NUMBER CC CD KL ERROR ID TC RM MK ST LS PT QT PS P
%left '+' '-'
%left '*' '/'
%type <val> expressao NUMBER termo
%type <val> pri_expressao
%type <name>  ID
%start input

%%

input :
			| input linha { printf("%s %s >>", getprogname(),getenv("PWD"));}
			;

linha: FIM_LINHA
			| expressao FIM_LINHA { printf("Valor : %g\n",$1);}
      | KL NUMBER FIM_LINHA { char ex[1024];
                              snprintf(ex , 1024 , "kill %d" , $2);
                              system(ex);
                              }
      | TC ID FIM_LINHA { char ex[1024]={}; strcat(ex, "touch ");strcat(ex, $2); system(ex);}
      | CD ID FIM_LINHA { char ex[1024]={}; strcat(ex, "cd ");strcat(ex, $2); system(ex);pr}
      | MK ID FIM_LINHA { char ex[1024]={}; strcat(ex, "mkdir ");strcat(ex, $2); system(ex);}
      | RM ID FIM_LINHA { char ex[1024]={}; strcat(ex, "rmdir ");strcat(ex, $2); system(ex);}
      | ST ID FIM_LINHA { char ex[1024]={}; strcat(ex, "open ");strcat(ex, $2); system(ex);}
      | LS FIM_LINHA { system("ls");}
      | PS FIM_LINHA { system("ps aux");}
      | QT FIM_LINHA { printf("Encerrando o programa..."); exit(0);}
      | ERROR FIM_LINHA { printf("Comando nao conhecido\n");return(0);}
      ;

expressao: termo { $$ = $1; }
					| expressao '+' termo { $$ = $1 + $3 ; }
					| expressao '-' termo { $$ = $1 - $3 ; }
					| '-' expressao { $$ = -$2 ; }
					;

termo: pri_expressao { $$ = $1; }
		  | termo '*' pri_expressao { $$ = $1 * $3 ; }
			| termo '/' pri_expressao { if ($3 != 0) $$ = $1 / $3 ;
															  else
																	 {
																 $$ = 0 ;
																 fprintf(stderr, "divisao por 0\n");
																 return(0);
																	 }
															 }
															 ;
pri_expressao : NUMBER { $$ = $1 ;}

%%

int main(int argc, char **argv)
{
  {printf("%s:%s >>", getprogname(),getenv("PWD"));}
   do {
    yyparse();
  } while (1) ;
}


void yyerror(char *msg)
{
    fprintf(stderr, "%s\n" , msg);
}
