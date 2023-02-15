#!/bin/bash

#SBATCH --job-name=rgi_array		## job name
#SBATCH -A <account name>		## account to charge
#SBATCH -p standard			## partition/queue name
#SBATCH --nodes=1               	## number of nodes to use
#SBATCH --ntasks=1              	## number of tasks to launch
#SBATCH --cpus-per-task=16		## number of cores the job needs
#SBATCH --error=slurm_%A_%a.err		## error log file name: %A is job id, %a is array task id
#SBATCH --output=slurm_%A_%a.out	## output filename
#SBATCH --array=1-21			## number of array tasks

## load modules
module load anaconda/2020.07

## activate conda environment
source activate rgi

## define directories
contigs=data/processed/contigs
output=data/processed/rgi

## create file name list
temp=$(basename -s .contig.fasta $contigs/*.contig.fasta | sort -u)

## select the file prefix corresponding to the array ID job number
prefix=`echo "$temp" | head -n $SLURM_ARRAY_TASK_ID | tail -n 1`

## job commands
rgi main \
--input_sequence $contigs/${prefix}.contig.fasta \
--output_file $output/${prefix} \
--local \
--clean \
--low_quality \
--num_threads $SLURM_CPUS_PER_TASK
