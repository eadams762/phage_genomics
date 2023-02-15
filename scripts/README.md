# Scripts for Phage Genome Processing and Analysis

Below is a summary of some of the scripts included in this repository and their purpose in the steps of processing and analysis of phage genomes. All scripts are written to be run on an HPC using SLURM for task management.

1. [Clean and Assemble](./clean_assemble_array.sh)

	This is an array script meant for parallel processing of paired reads for individual phage genomes. Adapters, phiX, and low quality base calls are trimmed using `bbduck.sh` from the BBTools package. Reads are then deduplicated using `dedupe.sh`, also from BBTools. Reads are then mapped against a human reference genome using `bowtie2` to remove any contaminant reads. Finally, the trimmed and cleaned reads are assembled using `unicycler`.

2. [Quality Reports](./reports.sh)

	This script renames assembly output files from unicycler. Generates FastQC reports of raw and cleaned read pairs, and aggregates these reports with MultiQC. Finally, it generates assembly statistics using Quast.

3. [Resistance Gene Identifier](./rgi_array.sh)

	This is an array script for parallel processing of phage contig files, checking for antimicrobial resistance genes against the Comprehensive Antibiotic Resistance Database (CARD) using the `RGI` utility.

4. [Kraken2](./kraken2.sh)

	This is an array script for parallel processing of phage contig files, assigning taxonomic classifications using kraken2 against the default database.
