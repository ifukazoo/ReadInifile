#include "extern.h"
#include "read_inifile.h"

int parse(FILE* fp, std::map<std::string, std::string>& map)
{
  yyin = fp;
  return yyparse(map);
}
