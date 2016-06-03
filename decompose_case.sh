#!/bin/bash

set -e

if [[ $# < 2 ]]
then
  echo "Usage: $0 CASE NCPU-1 [NCPU-2 NCPU-3 ...]"
  echo "Example: ./decompose_case.sh mik3d_15min 1 2 4 8 16 32"
  exit 1
fi

CASE=$1
shift
# ALL_NCPUS= $2 ...


function decomp_one() {
CASE=$1
NCPU=$2
rm -fr $CASE
rm -fr ${CASE}-${NCPU}cpu
tar -xzf ${CASE}.tar.gz
mv $CASE ${CASE}-${NCPU}cpu
sed -i "s/^numberOfSubdomains.*$/numberOfSubdomains $NCPU;/" ${CASE}-${NCPU}cpu/system/decomposeParDict

export FOAM_INST_DIR=../mike-apps/OpenFOAM
source ../mike-apps/OpenFOAM/OpenFOAM-2.4.0/etc/bashrc 
decomposePar -case ${CASE}-${NCPU}cpu

(cd ${CASE}-${NCPU}cpu && ln -s ../common/module.py)
echo "/openfoam/${CASE}-${NCPU}cpu/**:    \${MODULE_DIR}/**" >> ${CASE}-${NCPU}cpu/usr.manifest
}

while [[ $# > 0 ]]
do
  NCPU="$1"
  shift

  echo "Doing CASE=$CASE NCPU=$NCPU"
  decomp_one $CASE $NCPU
done

