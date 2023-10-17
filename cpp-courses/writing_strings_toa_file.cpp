// Copyright: Herpich F. R. 2023
// Description: Writing strings to a file named count.txt
// write the numbers 1 to 10, one per line, to the file

#include <filesystem>
#include <fstream>
#include <iostream>
#include <vector>

using namespace std;

int main() {
  vector<string> lines;
  for (int i = 1; i <= 10; i++) {
    lines.push_back(to_string(i));
  }

  ofstream file("count.txt");
  for (auto line : lines) {
    file << line << endl;
  }
  file.close();

  return 0;
}
