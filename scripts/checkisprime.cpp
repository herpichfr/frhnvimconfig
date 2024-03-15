// Copyright 2024 F Herpich
// This program checks if a number is prime
// It uses the Sieve of Eratosthenes algorithm
// to test if a given number is prime

#include <cmath>
#include <iostream>
#include <vector>

using namespace std;

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

int main() {
  int64_t n;
  cout << "Enter a number: ";
  cin >> n;
  if (isPrime(n)) {
    cout << n << " is prime" << endl;
  } else {
    cout << n << " is not prime" << endl;
  }
  return 0;
}

// Output
// Enter a number: 13
// 13 is prime
// Enter a number: 15
// 15 is not prime
// Enter a number: 23
// 23 is prime
