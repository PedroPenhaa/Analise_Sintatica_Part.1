%{
    #include "y.tab.h"
    #include <stdlib.h>
    void yyerror(char *);
%}

%%

[0-9]+  {
            yylval = atoi(yytext);
            return INTEGER;
        }

[-+\n] return *yytext;

[ \t] ;/* skip whitespace */

.    yyerror("invalid character");

%%

int yywrap(void)  {
    return 1;
}


decl.y

%{
    #include <stdio.h>
    int yylex(void);
    void yyerror(char *);
%}

%token INTEGER

%%

program :
        program expr '\n'  {printf("%d\n",$2);}
        |
        ;
expr:

        INTEGER                 { $$ = $1; }
        | expr '+' expr         { $$ = $1 + $3; }
        | expr '-' expr         { $$ = $1 - $3; }
   
%%

void yyerror(char *s) {
    printf("%s\n", s);
}

int main (void){
    yyparse();
    return 0;
}