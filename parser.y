%{
#include <stdio.h>
#include <string.h>
#include <map>
#include <string>

extern int yylineno;
extern int yylex();
extern int yyerror(std::map<std::string, std::string>&, const char*);

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

ws            :   { $$ = NULL; }
              | SPACES
                  {
                    char* p = strdup($1);
                    $$ = p;
                  }
              ;

words         : STR
                  {
                    char* p = strdup($1);
                    $$ = p;
                  }
              | words STR
                  {
                    strcat($1, $2);
                    $$ = $1;
                  }
              | words ws STR
                  {
                    strcat($1,$2); free($2);
                    strcat($1,$3);
                    $$ = $1;
                  }
              ;

symbol        : ws words ws
                  {
                    char* p = strdup($2);
                    free($1); free($2); free($3);
                    $$ = p;
                  }
              | ws '"' words '"' ws
                {
                  char* p = strdup($3);
                  free($1); free($3); free($5);
                  $$ = p;
                }
              ;
%%
int yyerror(std::map<std::string, std::string>&, const char*)
{
  // ignore
}
