#!/bin/bash

# ===========================================
# eclib-runs-status.sh
#
# Return current level of processes.
# ===========================================

# Number of system threads
N=60

# Number of program threads
T=4

# Level range
MIN=50000
MAX=60000

R=$(( $N / $T ))
RANGE=$(( $MAX - $MIN ))
INCREMENT=$(( $RANGE / $R ))

LOWER=$MIN

for (( n=1; n<=$R; n++ ))
do
    UPPER=$(( $MIN + $n*$INCREMENT ))

    # Correct last range
    if [ $n -eq $R ] && [ $UPPER -lt $MAX ]
    then
        UPPER=$MAX
    fi

    echo $LOWER - $UPPER : `tail -1 < tmanin_runtimes-$LOWER-$UPPER.dat`

    LOWER=$(( $UPPER+1 ))
done
