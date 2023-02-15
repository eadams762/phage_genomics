#!/bin/bash

SourceDir=<directory/with/raw/read/files>
DestDir=data/raw
FILES=$(basename -a $SourceDir/*)

for f in $FILES
do
   echo "Processing $f file..."
   ln -s $SourceDir/$f $DestDir/$f
done
