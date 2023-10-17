// Copyright 2023 Herpich F. R.

#include <iostream>

// write a variadic template, named summer
// accepts one or more integers
// adds all the numbers together
// returns the sum

template <typename T> T summer(T first) { return first; }

template <typename T, typename... Args> T summer(T first, Args... args) {
  return first + summer(args...);
}

int main() {
  std::cout << summer(1, 2, 3, 4, 5) << std::endl;
  std::cout << summer(1, 2, 3, 4, 5, 6, 7, 8, 9, 10) << std::endl;
  std::cout << summer(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 100) << std::endl;
  return 0;
}
