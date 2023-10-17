// Herpich 2023
// build demoed version of raii
// create "another" resource that needs to be destroyed
// it should take an integer in the constructor
// display that number upon construction/destruction

#include <iostream>

class Resource {
public:
  Resource() { std::cout << "Resource acquired\n"; }
  ~Resource() { std::cout << "Resource destroyed\n"; }
};

class AnotherResource {
public:
  AnotherResource(int n) : m_n(n) {
    std::cout << "AnotherResource acquired: " << m_n << "\n";
  }
  ~AnotherResource() {
    std::cout << "AnotherResource destroyed: " << m_n << "\n";
  }

private:
  int m_n;
};

class RAII {
public:
  RAII() : m_resource(), m_anotherResource(42) {}
  ~RAII() {}

private:
  Resource m_resource;
  AnotherResource m_anotherResource;
};

int main() {
  RAII raii;
  return 0;
}
