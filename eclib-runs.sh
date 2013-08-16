#!/bin/bash

# ===========================================
# eclib-runs.sh
#
# MAX OUT THE SYSTEM!
# Launch as many processes as possible.
# Work is divided as evenly as possible
# between threads.
# ===========================================

# Number of system threads
N=60

# Number of program threads
T=1

# Level range
MIN=50000
MAX=60000

R=$(( $N / $T ))
RANGE=$(( $MAX - $MIN ))
INCREMENT=$(( $RANGE / $R ))

LOWER=$MIN

# Loop over number of threads
for (( n=1; n<=$R; n++ ))
do
    UPPER=$(( $MIN + $n*$INCREMENT ))

    # Correct last range
    if [ $n -eq $R ] && [ $UPPER -lt $MAX ]
    then
        UPPER=$MAX
    fi

    ./tmanin_prof $LOWER $UPPER

    LOWER=$(( $UPPER+1 ))
done
