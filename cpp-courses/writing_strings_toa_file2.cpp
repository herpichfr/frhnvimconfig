// Copyright: Herpich F. R. 2023
// Description: Writing strings to a file named count.txt
// write the numbers 1 to 10, one per line, to the file

#include <filesystem>
#include <fstream>
#include <iostream>
#include <vector>

namespace fs = std::filesystem;
// namespace fs = std::experimental::filesystem;

void count_to_10() {
  fs::path fpath{"count.txt"};
  std::ofstream ofs{fpath};
  for (auto &ndx : {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}) {
    ofs << "Line # " << ndx << '\n';
  }
}

int main() {
  count_to_10();
  return 0;
}
