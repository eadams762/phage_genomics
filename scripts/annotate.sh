#!/bin/bash

## BV-BRC CLI command for RASTtk annotation
for f in $(basename -s .contig.fasta *.contig.fasta)
do
rast-create-genome --scientific-name "Enterococcous phage ${f}" --genetic-code 11 --domain Virus --contigs ${f}.contig.fasta \
| rast-process-genome \
| rast-export-genome genbank > ${f}.gbk
done
