#!/bin/bash

#--------------------------SBATCH settings------

#SBATCH --job-name=reports	## job name
#SBATCH -A class-ee282		## account name
#SBATCH -p standard		## partition/queue name
#SBATCH --nodes=1		## number of nodes to use
#SBATCH --ntasks=1		## number of tasks to launch
#SBATCH --cpus-per-task=16	## number of cores the job needs
#SBATCH --mem-per-cpu=6G	## requested memory (6G = max)
#SBATCH --error=slurm-%J.err	## error log file
#SBATCH --output=slurm-%J.out	##output info file

#-----------------------------------------------

# load modules
module load fastqc/0.11.9
module load anaconda/2020.07

# define directories
raw=data/raw
clean=data/processed/reads
mqc=output/reports/fastqc
fqc=data/raw/fastqc
assembly=data/processed/assembly

# assembly renaming
find $assembly -type f -name "assembly.fasta" -printf "/%P\n" | while read FILE ; do DIR=$(dirname "$FILE") ; mv $assembly/"$FILE" $assembly/"$DIR""$DIR".assembly.fasta ; done

find $assembly -type f -name "assembly.gfa" -printf "/%P\n" | while read FILE ; do DIR=$(dirname "$FILE") ; mv $assembly/"$FILE" $assembly/"$DIR""$DIR".assembly.gfa ; done

mv $assembly/*/*.fasta $assembly/
mv $assembly/*/*.gfa $assembly/

# fastqc reports
fastqc \
-o $fqc/raw/ \
--noextract \
-t $SLURM_CPUS_PER_TASK \
$raw/*.fastq.gz

fastqc \
-o $fqc/clean/ \
--noextract \
-t $SLURM_CPUS_PER_TASK \
$clean/*.fastq.gz

# multiqc reports
source activate multiqc
multiqc $fqc/raw/ -o $mqc/raw/
multiqc $fqc/clean/ -o $mqc/clean/

# quast assembly report
source activate quast
quast.py \
-o $assembly \
-t $SLURM_CPUS_PER_TASK \
--no-icarus \
$assembly/*.fasta
