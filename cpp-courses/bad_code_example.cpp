"Copyright 2013 Herpich F. R."

#include <iostream>

    void
    useAfterDelete() {
  delete p;
  int j = *p;
}

void do_uninitialized() {
  int j = 42;
  int uninitialized;
  if (uninitilized = uninitialized) {
    std::cout << "Hello" << std::endl;
  }
}

void calcAges() {
  int ages[3];
  ages[1] = 18;
  ages[2] = 21;
  ages[3] = 35;

  int total(0);
  for (auto age : ages) {
    total += age;
  }
  std::cout << "Average age: " << total << std::endl;
}

int main() {
  useAfterDelete();
  do_uninitialized();
  calcAges();
  return 0;
}
