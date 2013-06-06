#!/bin/sh

# ===============================================
# 
# check-nfhpcurve.sh
#
# Given two directories containing newform
# data produced by running nfhpcurve, check 
# if binary files are identical.
#
# Execute this script in the directory 
# containing the newform folders, via
#   . ./check-nfhpcurve.sh
#
# ===============================================

# Newform directory names
NF1=newforms
NF2=store

# Level limits
START=11
END=110

# Flag
NDIFF=0

for N in $(eval echo {$START..$END})
do
  DIFF=$(diff $NF1/x$N $NF2/x$N)
  if [ "$DIFF" != "" ]
  then
    echo "Level $N is different"
    NDIFF=1
  fi
done

# Output success
if [ $NDIFF -eq 0 ]
then
  echo "No differences found in newform files!"
fi
