#!/bin/sh

SPICE_ROOT=`pwd`
SRC_ROOT=$SPICE_ROOT/src
INST_ROOT=$SPICE_ROOT/rel

if [ ! -e $SRC_ROOT ]; then mkdir -p $SRC_ROOT; fi
if [ ! -e $INST_ROOT ]; then mkdir -p $INST_ROOT; fi

export PKG_CONFIG_PATH=$INST_ROOT/lib/pkgconfig:$INST_ROOT/share/pkgconfig
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INST_ROOT/lib
export PATH=$PATH:$INST_ROOT/bin
