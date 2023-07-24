# !/usr/bin/env python

import os

def get_cores_info():
    os.system("sensors | grep 'Core' > cpu_cores.txt")

    output = open('cpu_cores.txt', 'r').readlines()

    for i in range(len(output)):
        if i is 0:
            text = " 1 #(sensors | grep 'Core %i' | awk '{print $3}')" % i
        else:
            text += " %i #(sensors | grep 'Core %i' | awk '{print $3}')" % (i + 1, i)

    print text
    return

get_cores_info()
