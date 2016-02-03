%{
#include <string.h>
#include "extern.h"
%}
%union {
  char* s;
}

%token SPACES STR
%type <s> SPACES STR words ws symbol

%parse-param { std::map<std::string, std::string>& keyval }

%%

lines         :
              | lines keyvalline
              | lines error '\n'  {yyerrok;}
              ;

keyvalline    : symbol '=' symbol '\n'
                  {
                    keyval.insert(std::make_pair($1, $3));
                    free($1);free($3);
                  }
              ;
symbol        : ws words ws
                  {
                    $$ = strdup($2);
                    free($1); free($2); free($3);
                  }
              | ws '"' words '"' ws
                {
                  $$ = strdup($3);
                  free($1); free($3); free($5);
                }
              ;
ws            :        { $$ = NULL; }
              | SPACES { $$ = strdup($1); }
              ;
words         : STR       { $$ = strdup($1); }
              | words STR { $$ = strcat($1, $2); }
              | words ws STR
                  {
                    strcat($1,$2); free($2);
                    strcat($1,$3);
                    $$ = $1;
                  }
              ;
%%
int yyerror(std::map<std::string, std::string>&, const char*)
{
  // ignore
}
