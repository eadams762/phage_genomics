#!/bin/bash

SourceDir=/pub/adamsed/data/raw/phage
DestDir=/pub/adamsed/git_repos/phage_genomics/data/raw
FILES=$(basename -a $SourceDir/*)

for f in $FILES
do
   echo "Processing $f file..."
   ln -s $SourceDir/$f $DestDir/$f
done
