# !/usr/bin/env python

import os
import numpy as np

def get_cpu_info():
    os.system("sensors | grep 'Core' > cpu_cores.txt")

    output = open('cpu_cores.txt', 'r').readlines()

    temperatures = []

    for line in output:
        temperatures.append(np.float(line[15:19]))

    high_temp = np.array(temperatures).max()
    n_cores   = len(output)

    return n_cores, high_temp

print int(get_cpu_info()[1])
