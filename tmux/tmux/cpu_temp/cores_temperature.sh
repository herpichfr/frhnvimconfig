#!/bin/bash 

COUNTER=0
UPPER="$(sensors | grep 'Core' | wc -l)"
NUM=1

while [  $COUNTER -lt $UPPER ]; do
    TEMP="$(sensors | grep "Core $COUNTER" | awk '{print $3}')"
    if [ $COUNTER -le 0 ]; then
        STEM="Cores $NUM: $TEMP "
    else
        STEM+="$NUM: $TEMP "
    fi
    let COUNTER=COUNTER+1 
    let NUM=NUM+1
done
echo $STEM
