#/bin/bash

printf '%.1f%%' $(echo "$(free | grep Mem | awk '{print $3}') / $(free | grep Mem | awk '{print $2}') * 100" | bc -l)
