%option noyywrap nodefault yylineno
%s IQUOTE
%{
#include "extern.h"
#include "y.tab.h"
%}

%%

<INITIAL>(;|#)[^\n]* {
/* コメント */
}
<INITIAL>[ \t]+ {
  yylval.s = yytext;
  return SPACES;
}
<INITIAL>[^\" \t=\n]+ {
  yylval.s = yytext;
  return STR;
}
<INITIAL>"=" {
  return '=';
}
<INITIAL>"\"" {
  BEGIN IQUOTE;
  return '"';
}
<IQUOTE>"\"" {
  BEGIN INITIAL;
  return '"';
}
<IQUOTE>"\\\"" {
  // クオート内でエスケープ付きクオート
  yylval.s = &yytext[1];
  return STR;
}
<IQUOTE>"\\"  {
  // クオート内で単にBackSlash
  yylval.s = yytext;
  return STR;
}
<IQUOTE>[^\\"\n]+  {
  // クオート内では改行以外は全て取得
  yylval.s = yytext;
  return STR;
}
\n {
  BEGIN INITIAL;
  return '\n';
}
%%
