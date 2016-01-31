#include <iostream>
#include <string>
#include <map>
#include "y.tab.h"

int main(void)
{
  std::map<std::string, std::string> keyval;
  yyparse(keyval);

  for (auto kv : keyval) {
    std::cout << kv.first << ":" << kv.second << std::endl;
  }

  return 0;
}
