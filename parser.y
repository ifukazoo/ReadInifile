%{
#include <string.h>
#include <string>
#include "extern.h"

%}

%token SPACES STR

%parse-param { std::map<std::string, std::string>& keyval }

%%

lines         :
              | lines keyvalline
              | lines error '\n'       { yyerrok;}
              ;

keyvalline    : symbol '=' symbol '\n' { keyval.insert(std::make_pair($1, $3)); }
              ;
symbol        : ws words ws            { $$ = std::string($2); }
              | ws '"' words '"' ws    { $$ = std::string($3); }
              ;
ws            :                        { $$ = ""; }
              | SPACES                 { $$ = std::string($1); }
              ;
words         : STR                    { $$ = std::string($1); }
              | words STR              { $$ = std::string($1) + std::string($2); }
              | words ws STR           { $$ = std::string($1) + std::string($2) + std::string($3); }
              ;
%%
int yyerror(std::map<std::string, std::string>&, const char*)
{
  // ignore
}
