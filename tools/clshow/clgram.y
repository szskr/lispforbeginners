/*
 * common lisp simplied grammar
 */

%{
#include <stdio.h>
%}


%token <val> id
%type <val> S
%type <val> E
%type <val> T
%type <val> F

%%
S : E '\n' { $$ = $1;
    printf("\tval = %d\n", $$);
    return (0);
  }
  ;

E : E '+' T {$$ = $1 + $3;}
  | T       {$$ = $1;}
  ;

T : T '*' F {$$ = $1 * $3;}
  | F       {$$ = $1;}
  ;

F : '(' E ')' {$$ = $2;}
  | id        {$$ = $1;}
  ;

%%
