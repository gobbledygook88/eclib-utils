#!/bin/sh

# ==========================================
# install-eclib.sh
#
# Install ECLIB (and all its dependencies
# on any UNIX system). These are
#   Autoconf
#   Automake
#   Libtool
#   GMP
#   NTL
#   Pari
#   mpir
#   mpfr
#   FLINT
#   Boost
# 
# To install, run the following in a prompt
#   . ./install-eclib.sh
#
# Enjoy afternoon tea.
#
# Installation can be configured by
# changing values below.
#
# ==========================================




# ==========================================
# Configuration
# ==========================================

# Install directory for all packages
PKGDIR="${HOME}/Packages"

# Package version numbers
VERAUTOCONF="2.69"
VERAUTOMAKE="1.13.2"
VERLIBTOOL="2.4.2"
VERGMP="5.1.2"
VERNTL="6.0.0"
VERPARI="2.5.4"
VERMPIR="2.6.0"
VERMPFR="3.1.2"
VERFLINT="2.3"
VERBOOST="1.53.0"

# Flags 
CHECKFLAG=0           # Perform 'make check'
FLINTFLAG=1           # Use FLINT library
WGETFLAGS=-q          # Quiet
MAKEFLAGS=-s          # Silent make

# ==========================================
# End configuration
# ==========================================




# File extensions
TARGZ=".tar.gz"
TARXZ=".tar.xz"
TARBZ=".tar.bz2"
ZIP=".zip"

# Package file names
AUTOCONF="autoconf-${VERAUTOCONF}"
AUTOMAKE="automake-${VERAUTOMAKE}"
LIBTOOL="libtool-${VERLIBTOOL}"
GMP="gmp-${VERGMP}"
NTL="ntl-${VERNTL}"
PARI="pari-${VERPARI}"
MPIR="mpir-${VERMPIR}"
MPFR="mpfr-${VERMPFR}"
FLINT="flint-${VERFLINT}"
BOOST="boost_${VERBOOST//./_}"
ECLIB="eclib-master"

# Package URLs
URLAUTOCONF="http://ftp.gnu.org/gnu/autoconf/${AUTOCONF}${TARGZ}"
URLAUTOMAKE="http://ftp.gnu.org/gnu/automake/${AUTOMAKE}${TARGZ}"
URLLIBTOOL="http://ftp.heanet.ie/mirrors/gnu/libtool/${LIBTOOL}${TARGZ}"
URLGMP="ftp://ftp.gmplib.org/pub/${GMP}/${GMP}${TARXZ}"
URLNTL="http://www.shoup.net/ntl/${NTL}${TARGZ}"
URLPARI="http://pari.math.u-bordeaux.fr/pub/pari/unix/${PARI}${TARGZ}"
URLMPIR="http://www.mpir.org/${MPIR}${TARBZ}"
URLMPFR="http://www.mpfr.org/mpfr-current/${MPFR}${TARGZ}"
URLFLINT="http://www.flintlib.org/${FLINT}${TARGZ}"
URLBOOST="http://sourceforge.net/projects/boost/files/boost/${VERBOOST}/${BOOST}${TARGZ}/download"
URLECLIB="https://github.com/JohnCremona/eclib/archive/master.zip"




# Define make function helper
makeaway() {
make $MAKEFLAGS
# [[ $CHECKFLAG -ne 0 ]] && { make check }
make install
cd ..  # Move up one directory
}




# Check autotools versions




# Download all packages 
# and place in current directory
echo ""
echo "Downloading all packages into current directory"
echo "  Downloading autoconf"
wget $WGETFLAGS $URLAUTOCONF
echo "  Downloading automake"
wget $WGETFLAGS $URLAUTOMAKE
echo "  Downloading libtool"
wget $WGETFLAGS $URLLIBTOOL
echo "  Downloading GMP"
wget $WGETFLAGS $URLGMP 
echo "  Downloading NTL"
wget $WGETFLAGS $URLNTL 
echo "  Downloading Pari"
wget $WGETFLAGS $URLPARI 
echo "  Downloading mpir"
wget $WGETFLAGS $URLMPIR
echo "  Downloading mpfr"
wget $WGETFLAGS $URLMPFR
echo "  Downloading FLINT"
wget $WGETFLAGS $URLFLINT
echo "  Downloading Boost"
wget $WGETFLAGS $URLBOOST
echo "  Downloading ECLIB"
wget $WGETFLAGS $URLECLIB




# Declare beginning of installation
# with installation path
echo ""
echo "Installing all packages in $PKGDIR"

# Install autoconf
echo "  Installing autoconf"
tar -xvf $AUTOCONF$TARGZ
cd $AUTOCONF
./configure --prefix=$PKGDIR
makeaway
# Setup new environment variables
. ./setup-eclib.sh

# Install automake
echo "  Installing automake"
tar -xvf $AUTOMAKE$TARGZ
cd $AUTOMAKE
./configure --prefix=$PKGDIR
makeaway

# Install libtool
echo "  Installing libtool"
tar -xvf $LIBTOOL$TARGZ
cd $LIBTOOL
./configure --prefix=$PKGDIR
makeaway

# Install GMP
echo "  Installing GMP"
tar -xvf $GMP$TARXZ
cd $GMP
./configure --prefix=$PKGDIR
makeaway

# Install NTL
echo "  Installing NTL"
tar -xvf $NTL$TARGZ
cd $NTL/src
./configure PREFIX=$PKGDIR NTL_GMP_LIP=on GMP_PREFIX=$PKGDIR SHARED=on
makeaway
cd .. # NTL requires an extra move up directory

# Install Pari
echo "  Installing Pari"
tar -xvf $PARI$TARGZ
cd $PARI
./Configure --prefix=$PKGDIR --with-gmp=$PKGDIR
makeaway

# Install mpir
echo "  Installing mpir"
tar -xvf $MPIR$TARBZ
cd $MPIR
./configure --prefix=$PKGDIR
makeaway

# Install mpfr
echo "  Installing mpfr"
tar -xvf $MPFR$TARGZ
./configure --prefix=$PKGDIR --with-gmp=$PKGDIR
cd $MPFR
makeaway

# Install FLINT
echo "  Installing FLINT"
tar -xvf $FLINT$TARGZ
cd $FLINT
./configure --prefix=$PKGDIR --with-mpir=$PKGDIR --with-mpfr=$PKGDIR --with-ntl=$PKGDIR
makeaway

# Install Boost
echo "  Installing Boost"
tar -xvf download 
cd $BOOST
echo "using mpi ;" >> tools/build/v2/user-config.jam
./bootstrap.sh --prefix=$PKGDIR
./b2 install --prefix=$PKGDIR

# Install ECLIB
echo "  Installing ECLIB"
unzip $ECLIB$ZIP
cd $ECLIB
./autogen.sh
./configure --prefix=$PKGDIR --with-ntl=$PKGDIR --with-pari=$PKGDIR --with-flint=$PKGDIR
makeaway




# Installation of all packages complete
# Perform clean up
rm -rf $GMP$TARXZ $GMP
rm -rf $NTL$TARGZ $NTL
rm -rf $PARI$TARGZ $PARI
rm -rf $MPIR$TARBZ $MPIR
rm -rf $MPFR$TAR $MPFR
rm -rf $FLINT$TARGZ $FLINT
rm -rf $ECLIB$ZIP  




# All done. Huzzah!
