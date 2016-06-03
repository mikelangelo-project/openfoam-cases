#!/bin/bash

foamLog log


tail -n+5 postProcessing/forceCoeffs1/0/forces.dat > postProcessing/forceCoeffs1/0/forces1.dat
tail -n+4 postProcessing/forceCoeffs1/0/forces.dat > postProcessing/forceCoeffs1/0/forces2.dat
head -n -1 postProcessing/forceCoeffs1/0/forces2.dat  > postProcessing/forceCoeffs1/0/forces3.dat
# displays all lines from the 9th line forward.

sed -i 's/[(,)]//g' postProcessing/forceCoeffs1/0/forces1.dat
sed -i 's/[(,)]//g' postProcessing/forceCoeffs1/0/forces3.dat

gnuplot AllToPlot
