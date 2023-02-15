#!/bin/bash

#--------------------------SBATCH settings------

#SBATCH --job-name=kraken2_array        ## job name
#SBATCH -A <account name>               ## account to charge
#SBATCH -p standard                     ## partition/queue name
#SBATCH --nodes=1                       ## number of nodes to use
#SBATCH --ntasks=1                      ## number of tasks to launch
#SBATCH --cpus-per-task=20              ## number of cores the job needs
#SBATCH --error=slurm_%A_%a.err         ## error log file name: %A is job id, %a is array task id
#SBATCH --output=slurm_%A_%a.out        ## output filename
#SBATCH --array=1-18                    ## number of array tasks

#-----------------------------------------------

# load module
module load kraken2/2.1.2

# define directories
contigs=data/processed/contigs
output=data/processed/kraken2
db=</path/to/database/kraken2_db>

## create file name list
temp=$(basename -s .contig.fasta $contigs/*.contig.fasta | sort -u)

## select the file prefix corresponding to the array ID job number
prefix=`echo "$temp" | head -n $SLURM_ARRAY_TASK_ID | tail -n 1`


# job commands
kraken2 \
--db $db \
--threads $SLURM_CPUS_PER_TASK \
--report $output/${prefix} \
$contigs/${prefix}.contig.fasta
