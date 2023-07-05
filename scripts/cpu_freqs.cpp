/***********************************************************************************
 *                                                                                  *
 *  Copyright (c) 2023, Herpich F. R / CASU/IoA Cambridge *
 *                                                                                  *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 ** of this software and associated documentation files (the "Software"), to
 *deal   * in the Software without restriction, including without limitation the
 *rights    * to use, copy, modify, merge, publish, distribute, sublicense,
 *and/or sell       * copies of the Software, and to permit persons to whom the
 *Software is           * furnished to do so, subject to the following
 *conditions:                        *
 *                                                                                  *
 *  The above copyright notice and this permission notice shall be included in *
 *  all copies or substantial portions of the Software. *
 *                                                                                  *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR *
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, *
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 ** AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER *
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 *FROM,   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 *DEALINGS IN       * THE SOFTWARE. *
 *                                                                                  *
 ***********************************************************************************/
// Description: A program to display the CPU model and frequencies in real time
// Author: Fabio R Herpich
// Date: 2021-05-03
// License: Please see LICENSE.txt
// Usage: g++ -std=c++17 -Wall -Wextra -pedantic -O3 -o cpu_freqs cpu_freqs.cpp
//       ./cpu_freqs
//       Press Ctrl+C to exit
//       Press Ctrl+Z to pause
//       Press Ctrl+Z again to resume
//       Press Ctrl+\ to quit
//       Press Ctrl+Z and then Ctrl+\ to quit immediately
//
// The program will display the CPU model and frequencies in real time

#include <chrono>
#include <csignal>
#include <cstdlib>
#include <filesystem>
#include <fstream>
#include <iomanip> // Include the <iomanip> header for formatting
#include <iostream>
#include <regex>
#include <string>
#include <sys/time.h>
#include <thread>
#include <vector>

// Global variables to store the CPU model and frequencies
std::string model;
std::vector<float> freqs;

// Function to update the CPU model and frequencies
void update() {
  // Get the path where the program lives
  std::filesystem::path executablePath =
      std::filesystem::canonical("/proc/self/exe");
  std::string path = std::string(executablePath.parent_path()) + "/";
  // Get the CPU model and save in the file mode.txt in the same directory
  std::system(("lscpu | grep 'Model name' | awk '{print "
               "$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15}' > " +
               path + "model.txt")
                  .c_str());
  // Get the CPU frequencies and save in the file freqs.txt in the same
  // directory
  std::system(("cat /proc/cpuinfo | grep MHz | awk '{print $4}' > " + path +
               "freqs.txt")
                  .c_str());

  // Read the CPU model from the file path + model.txt
  std::ifstream modelFile(path + "model.txt");
  std::getline(modelFile, model);

  // Read the CPU frequencies from the file path + freqs.txt
  std::ifstream freqsFile(path + "freqs.txt");
  std::string line;
  freqs.clear();
  while (std::getline(freqsFile, line)) {
    // Convert the frequency string to float
    float freq = std::stof(line);
    freqs.push_back(freq);
  }
}

// Function to print the CPU model and frequencies
void print() {
  // Clear screen
  std::cout << "\033[2J\033[1;1H";

  // Print CPU model
  std::cout << "\033[0m" << model << "\n\n";

  // Print CPU frequencies in GHz with 2 decimal places
  for (std::size_t i = 0; i < freqs.size(); ++i) {
    if (freqs[i] <= 2500) {
      std::cout << "\033[0mCPU " << std::setw(2) << std::setfill('0') << i + 1
                << ": " << std::fixed << std::setprecision(2)
                << freqs[i] / 1000.0f << " GHz\033[0m\n";
    } else if (freqs[i] <= 3400) {
      std::cout << "\033[44mCPU " << std::setw(2) << std::setfill('0') << i + 1
                << ": " << std::fixed << std::setprecision(2)
                << freqs[i] / 1000.0f << " GHz\033[0m\n";
    } else if (freqs[i] <= 4200) {
      std::cout << "\033[43mCPU " << std::setw(2) << std::setfill('0') << i + 1
                << ": " << std::fixed << std::setprecision(2)
                << freqs[i] / 1000.0f << " GHz\033[0m\n";
    } else {
      std::cout << "\033[41mCPU " << std::setw(2) << std::setfill('0') << i + 1
                << ": " << std::fixed << std::setprecision(2)
                << freqs[i] / 1000.0f << " GHz\033[0m\n";
    }
  }
}

// Signal handler to update and print when SIGALRM is received
void handler(int signum) {
  update();
  print();
}

int main() {
  // Set up a timer to send SIGALRM every second
  struct itimerval timer;
  timer.it_value.tv_sec = 1;
  timer.it_value.tv_usec = 0;
  timer.it_interval.tv_sec = 1;
  timer.it_interval.tv_usec = 0;
  setitimer(ITIMER_REAL, &timer, NULL);

  // Register the signal handler for SIGALRM
  signal(SIGALRM, handler);

  // Wait for signals in an infinite loop
  while (true) {
    pause();
  }

  return 0;
}
