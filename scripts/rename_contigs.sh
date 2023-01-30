#!/bin/bash

for F in $(basename -s .fasta *.fasta)
do
bioawk -c fastx '{ print ">" substr(FILENAME, 1, length(FILENAME)-6); print $seq }' ${F}.fasta > ${F}.contig.fasta
done
