#include <iostream>
#include "read_inifile.h"

int main(int argc, char const* argv[])
{
  bool use_file = false;
  FILE* fp = nullptr;
  if (argc < 2) {
    fp = stdin;
  } else {
    if ((fp = fopen(*++argv, "r")) == nullptr) {
      exit(EXIT_FAILURE);
    }
    use_file = true;
  }

  std::map<std::string, std::string> keyval;
  parse(fp, keyval);

  for (auto kv : keyval) {
    std::cout << kv.first << ":" << kv.second << std::endl;
  }

  if (use_file) {
    fclose(fp);
  }

  return 0;
}
