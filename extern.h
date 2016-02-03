#ifndef _READ_INIFILE_EXTERN_H_
#define _READ_INIFILE_EXTERN_H_

#include <cstdio>
#include <map>
#include <string>

extern "C" {
extern int yylex(void);
}
extern FILE* yyin;
extern int yyerror(std::map<std::string, std::string>&, const char*);
extern int yyparse(std::map<std::string, std::string>&);

#endif
