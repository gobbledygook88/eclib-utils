#!/bin/sh

# =========================================================
#
# setup-eclib.sh
#
# Sets PATH, LD_LIBRARY_PATH,
# C_INCLUDE_PATH, CPLUS_INCLUDE_PATH
# with respect to location given
# by PKGDIR.
#
# Execute by sourcing the shell script
# 
#  . ./setup-eclib.sh
#
# =========================================================

# Base directory
PKGDIR=$HOME/Packages




# Setup local PATH to run new autotools,
# libtool and eclib programs
echo ""
echo "  Adding $PKGDIR/bin     to PATH"
export PATH=$PKGDIR/bin:$PATH

# Setup local LD_LIBRARY_PATH
# for new library files
echo "  Adding $PKGDIR/lib     to LD_LIBRARY_PATH"
export LD_LIBRARY_PATH=$PKGDIR/lib:$LD_LIBRARY_PATH

# Setup local library include paths
echo "  Adding $PKGDIR/include to C/CPLUS_INCLUDE_PATH"
export C_INCLUDE_PATH=$PKGDIR/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$PKGDIR/include:$CPLUS_INCLUDE_PATH

# Notify completion
echo ""
echo "  Environment variables setup complete"
echo ""
