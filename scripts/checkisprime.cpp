// Copyright 2024 F Herpich
// This program checks if a number is prime
// It uses the Sieve of Eratosthenes algorithm
// to test if a given number is prime

#include <algorithm>
#include <cmath>
#include <iostream>
#include <vector>

using namespace std;

class InputParser {
public:
  InputParser(int &argc, char **argv) {
    for (int i = 1; i < argc; ++i)
      this->tokens.push_back(string(argv[i]));
  }

  const string &getCmdOption(const string &option) const {
    vector<string>::const_iterator itr;
    itr = find(this->tokens.begin(), this->tokens.end(), option);
    if (itr != this->tokens.end() && ++itr != this->tokens.end()) {
      return *itr;
    }
    static const string empty_string("");
    return empty_string;
  }

  bool cmdOptionExists(const string &option) const {
    return find(this->tokens.begin(), this->tokens.end(), option) !=
           this->tokens.end();
  }

private:
  vector<string> tokens;
};

bool isPrime(int n) {
  if (n <= 1)
    return false;
  if (n == 2)
    return true;
  if (n % 2 == 0)
    return false;
  for (int i = 3; i <= sqrt(n); i += 2) {
    if (n % i == 0)
      return false;
  }
  return true;
}

int main(int argc, char **argv) {
  InputParser input(argc, argv);
  if (input.cmdOptionExists("-h")) {
    cout << "Usage: " << argv[0] << " -n <number>" << endl;
    return 0;
  }
  if (!input.cmdOptionExists("-n")) {
    cout << "Error: You must provide a number to check" << endl;
    return 1;
  }
  int64_t n = stoll(input.getCmdOption("-n"));
  if (isPrime(n)) {
    cout << n << " is prime" << endl;
  } else {
    cout << n << " is not prime" << endl;
  }
  return 0;
}
