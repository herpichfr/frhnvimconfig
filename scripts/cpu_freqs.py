#!/bin/python3

import subprocess
import time

while True:
    command = "lscpu | grep 'Model name' | awk '{print $4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15}'"
    try:
        model = subprocess.check_output(
            command, shell=True, stderr=subprocess.STDOUT)  # get cpu model
    except subprocess.CalledProcessError as e:
        print(e.output)
        exit(1)

    command = "cat /proc/cpuinfo | grep MHz | awk '{print $4}'"
    try:
        freqs = subprocess.check_output(
            command, shell=True, stderr=subprocess.STDOUT)  # get cpu freqs
        freqs = freqs.decode('utf-8').split('\n')  # decode and split output
    except subprocess.CalledProcessError as e:
        print(e.output)
        exit(1)

    freqs = list(filter(None, freqs))
    freqs = list(map(float, freqs))
    print("\033[2J\033[1;1H", end="")
    text = model.decode('utf-8') + '\n'
    for i in range(len(freqs)):
        if freqs[i] <= 2500:
            text += "\033[0mCore {:2s}: {:.2f} GHz\033[0m\n".format(
                repr(i+1), freqs[i]/1000)
        elif freqs[i] <= 3400:
            text += "\033[44mCore {:2s}: {:.2f} GHz\033[0m\n".format(
                repr(i+1), freqs[i]/1000)
        elif freqs[i] <= 4200:
            text += "\033[43mCore {:2s}: {:.2f} GHz\033[0m\n".format(
                repr(i+1), freqs[i]/1000)
        else:
            text += "\033[41mCore {:2s}: {:.2f} GHz\033[0m\n".format(
                repr(i+1), freqs[i]/1000)

    print(text[:-1], end='\r')  # print output without last \n
    time.sleep(1)
