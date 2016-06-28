Example OpenFOAM datasets for testing OpenFOAM on OSv.

# Prerequisite

Uses git LFS, so install it before cloning.
From https://git-lfs.github.com/:
```
# Fedora
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | sudo bash
sudo dnf install git-lfs
```

# Use existing cases

After checkout, add it to OSv `config.json` repositories:
```
osv/config.json:
{
...
    "repositories": [
        "${OSV_BASE}/apps",
        "${OSV_BASE}/modules"
        , "${OSV_BASE}/../openfoam-cases"
    ]
```

## Preparing a new case

Compile decomposePar utility.
```
cd mike-apps/OpenFOAM
# from GET script:
VERSION=2.4.0
BASEDIR=$PWD
ROOTFS=$BASEDIR/ROOTFS
SRCDIR=$BASEDIR/OpenFOAM-$VERSION

export FOAM_INST_DIR=$BASEDIR
source $SRCDIR/etc/bashrc
cd $SRCDIR/applications/utilities/parallelProcessing/decomposePar/
wmake
# might be needed
# sudo yum install scotch-devel
cd $SRCDIR/src/parallel/decompose/scotchDecomp
wmake

```

Untar dataset, and decompose it.
```
cd openfoam-cases/
CASE=mik3d_1h
NCPU=8

rm -fr $CASE
tar -xzf ${CASE}.tar.gz
mv $CASE ${CASE}-${NCPU}cpu
sed -i "s/^numberOfSubdomains.*$/numberOfSubdomains $NCPU;/" ${CASE}-${NCPU}cpu/system/decomposeParDict

export FOAM_INST_DIR=../mike-apps/OpenFOAM
source ../mike-apps/OpenFOAM/OpenFOAM-2.4.0/etc/bashrc 
decomposePar -case ${CASE}-${NCPU}cpu
```
